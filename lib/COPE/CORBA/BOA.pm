# $Id: BOA.pm,v 1.10 1997/07/31 11:03:52 schuller Exp $
# Copyright (c) 1997 Lunatech Research / Bart Schuller <schuller@lunatech.com>
# See the file "Artistic" in the distribution for licensing and
# (lack of) warranties.
# interface CORBA::BOA

package CORBA::BOA;
use COPE::CORBA::ServerRequest;
use COPE::GIOP;
use IO::Socket;
use Net::Domain ();
use COPE::CORBA::Exception;
use Data::Dumper;

$CORBA::BOA::_The_Boa = 0;

sub myread ($\$$;$);
sub mywrite ($\$$);

sub new {
    my($class,$orb,$argv,$boa_identifier) = @_;
    my $boa = {};
    my $domain = Net::Domain::hostfqdn();
    $domain =~ s/[\r\n]+//g;
    $boa->{host} = $domain;
    $boa->{port} = $orb->{port};
    my $localaddr = $domain;
    if ($boa->{port}) {
        $localaddr .= ":$boa->{port}";
    }
    $boa->{'socket'} = IO::Socket::INET->new(
                    LocalAddr => $localaddr,
                    Proto     => 'tcp',
                    Listen    => 5,
                    Reuse     => 1 );
    $boa->{port} ||= $boa->{'socket'}->sockport();
    $boa->{byte_order} = $orb->{byte_order};
    $boa->{'clients'} = [];

    return $CORBA::BOA::_The_Boa = bless $boa, $class;
}

sub create ($$$$) {
    my($self,$id,$intf,$impl) = @_;
}

sub _create ($$$) {
    my($self,$id,$idef,$impl) = @_;
    my $obj = {};
    $obj->{'id'} = $id;
    $obj->{'interface'} = $idef;
    $obj->{'impl'} = $impl;
    $self->{'objects'}{$id} = $obj;
    $self->{'skeletons'}{$impl} = $obj;
    return bless $obj, 'CORBA::Object';
}

sub dispose ($$) {
    my($self,$obj) = @_;
}

sub get_id ($$) {
    my($self,$obj) = @_;
    return $obj->{'id'};
}

sub change_implementation ($$$) {
    my($self,$obj,$impl) = @_;
    # Remove the old implementation from the skeletons hash
    delete $self->{'skeletons'}{$obj->{'impl'}};
    $obj->{'impl'} = $impl;
    $self->{'skeletons'}{$impl} = $obj;
}

sub impl_is_ready ($$) {
    my($self,$impl) = @_;
    my $server = $self->{'socket'};
    my($rin,$rout,$client);
    while(1) {
        $rin = '';
        foreach ($server, @{$self->{'clients'}}) {
            vec($rin,fileno($_),1) = 1;
        }
        select($rout=$rin, undef, undef, undef);
        foreach (@{$self->{'clients'}}) {
            if(vec($rout,fileno($_),1)) {
                $self->_handle_request($_);
            }
        }
        if (vec($rout,fileno($server),1)) {
            ($client, undef) = $server->accept;
            push @{$self->{'clients'}}, $client;
            $self->_handle_request($client);
        }
    }
}

sub deactivate_impl ($$) {
    my($self,$impl) = @_;
}

sub obj_is_ready ($$$) {
    my($self,$obj,$impl) = @_;
}

sub deactivate_obj ($$) {
    my($self,$obj) = @_;
}

# not in interface

sub _handle_request {
    my($self,$socket) = @_;
    my($data,$index,$byte_order, $client_ind);
    if( myread($socket,$data, 12) <= 0 ) {
    # client has left, have to remove the client. 
        $client_ind = 0;
        foreach( @{$self->{'clients'}} ) {
            if( $_ eq $socket ) {
                splice( @{$self->{'clients'}}, $client_ind, 1 );
                # remove this entry from array
            }
            $client_ind += 1;
        }
        return;
     }

    $index = 0;
    my $msgh = GIOP::MessageHeader::_unmarshal(\$data, \$index, \$byte_order);
    if( myread($socket,$data, $msgh->{message_size},$index) <= 0 ) {
    # client has left, have to remove the client. 
        $client_ind = 0;
        foreach( @{$self->{'clients'}} ) {
            if( $_ eq $socket ) {
                splice( @{$self->{'clients'}}, $client_ind, 1 );
                # remove this entry from array
            }
            $client_ind += 1;
        }
        return;
    }

    my $rh = GIOP::RequestHeader::_unmarshal(\$data, \$index, $byte_order);
    my $target = $self->{objects}{$rh->{object_key}};
    if (!$target) {
        die "No such object: $rh->{object_key}";
    }
    my $operation = $rh->{operation};
    my $serverrequest = CORBA::ServerRequest->new($operation, $byte_order, $data, $index);
    $operation =~ s/^_(get|set)_//;
    my $exception;
    try {
        $target->$operation($serverrequest);
    } catch 'Default' => sub {
        $exception = $_[0];
    };
    my $reply_header = GIOP::ReplyHeader->new(
        service_context =>  [],
        request_id      =>  $rh->{request_id},
        reply_status    =>  $exception ? 1 : 0,
    );
    my $reply = '';
    $index = 0;
    $byte_order = $self->{byte_order};
    GIOP::ReplyHeader::_marshal(\$reply, \$index, $byte_order, $reply_header);
    if ($exception) {
        my $tc = ref $exception;
        no strict 'refs';
        $tc = ${"${tc}::_tc"};
        CORBA::ORB::_marshal_using_tc(\$reply, \$index, $byte_order, $exception, $tc);
    } else {
        my $result = $serverrequest->get_result();
        if ($result) {
            CORBA::ORB::_marshal_using_tc(\$reply, \$index, $byte_order, $result->{_value}, $result->{_type});
        }
        my $arg_list = $serverrequest->get_arglist();
        my $argnum = 1;
        foreach my $arg (@{$arg_list}) {
            $argnum++;
            if (($arg->{arg_modes}==1)||($arg->{arg_modes}==2)) {
                CORBA::ORB::_marshal_using_tc(\$reply, \$index, $byte_order, $arg->{argument}{_value}, $arg->{argument}{_type});
            }
        }
    }
    $msgh = GIOP::MessageHeader->new(
        magic           => 'GIOP',
        GIOP_version    => new GIOP::Version(major => chr(1), minor => chr(0)),
        byte_order      => $byte_order,
        message_type    => GIOP::Reply,
        message_size    => $index,
    );
    $data = '';
    $index = 0;
    GIOP::MessageHeader::_marshal(\$data,\$index,$byte_order,$msgh);
    $data .= $reply;
    mywrite($socket, $data, length($data));
}

sub myread ($\$$;$) {
    my($fh,$varref,$length,$index) = @_;
    if (!defined($index)) {
        $index = 0;
    }
    my $read = $index;
    $length += $index;
    while ($read < $length) {
        my $r = $fh->sysread($$varref, $length-$read, $read);
        if ($r > 0) {
            $read += $r;
        } else {
	    # Client may die, return anyway.
	    return $r;
        }
    }
    return $read-$index;
}

sub mywrite ($\$$) {
    my($fh,$varref,$length) = @_;
    my $written = 0;
    while ($written < $length) {
        my $r = $fh->syswrite($$varref, $length-$written, $written);
        if ($r > 0) {
            $written += $r;
        } else {
            sleep 1;
        }
    }
    return $written;
}

1;
