# $Id: Request.pm,v 1.4 1997/07/31 11:03:53 schuller Exp $
# Copyright (c) 1997 Lunatech Research / Bart Schuller <schuller@lunatech.com>
# See the file "Artistic" in the distribution for licensing and
# (lack of) warranties.

# interface Request
package CORBA::Request;
use COPE::GIOP;
use IO::Socket;
use Data::Dumper;
use COPE::CORBA::TCKind;
use COPE::CORBA::Exception;

$CORBA::Request::request_id = 0;
%CORBA::Request::connections = ();

sub add_arg ($$$$$$) {
    my($self,$name,$arg_type,$value,$len,$arg_flags) = @_;
}

sub invoke ($$) {
    my($self,$invoke_flags) = @_;
    my $request_header = GIOP::RequestHeader->new(
        service_context => [],
        request_id => $CORBA::Request::request_id++,
        response_expected   => 1,   # FIXME
        object_key      => $self->{object_key},
        operation      => $self->{operation},
        requesting_principal    =>  '', # FIXME
    );
    my $request = '';
    my $index = 0;
    my $byte_order = $self->{orb}{byte_order};
    GIOP::RequestHeader::_marshal(\$request, \$index, $byte_order, $request_header);
    foreach my $arg (@{$self->{arg_list}}) {
        if (($arg->{arg_modes}==0)||($arg->{arg_modes}==2)) {
            CORBA::ORB::_marshal_using_tc(\$request, \$index, $byte_order, $arg->{argument}{_type}->_needs_ref($arg->{arg_modes}) ? ${$arg->{argument}{_value}} : $arg->{argument}{_value}, $arg->{argument}{_type});
        }
    }
    my $message_header = GIOP::MessageHeader->new(
        magic           =>  'GIOP',
        GIOP_version    => new GIOP::Version(major => chr(1), minor => chr(0)),
        byte_order      => $byte_order,
        message_type    => GIOP::Request,
        message_size    => $index,
    );
    my $msg = '';
    $index = 0;
    GIOP::MessageHeader::_marshal(\$msg,\$index,$byte_order,$message_header);
    $msg .= $request;
    my $length = length($msg);
    $index = 0;
    my $connection = $self->get_connection();
    while ($index < $length) {
        $index += syswrite($connection, $msg, $length-$index, $index);
    }

    my $reply;
    sysread($connection, $reply, 12); # FIXME
    $index = 0;
    my $reply_mh = GIOP::MessageHeader::_unmarshal(\$reply, \$index, \$byte_order);
    $byte_order = $reply_mh->{byte_order};
    $index = 0;
    while ($index < $reply_mh->{message_size}) {
        $index += sysread($connection, $reply, $reply_mh->{message_size}-$index, $index);
    }
    $index = 0;
    my $reply_header = GIOP::ReplyHeader::_unmarshal(\$reply, \$index, $byte_order);
    if ($reply_header->{reply_status} == GIOP::NO_EXCEPTION) {
        $self->{result}{_value} = CORBA::ORB::_unmarshal_using_tc(\$reply, \$index, $byte_order, $self->{result}{_type});
        foreach my $arg (@{$self->{arg_list}}) {
            if (($arg->{arg_modes}==1)||($arg->{arg_modes}==2)) {
                if ((($arg->{argument}{_type}->kind() == tk_sequence) || ($arg->{argument}{_type}->kind() == tk_array)) && ($arg->{argument}{_type}->content_type()->kind() != tk_octet)) {
                    @{$arg->{argument}{_value}} = @{CORBA::ORB::_unmarshal_using_tc(\$reply, \$index, $byte_order, $arg->{argument}{_type})};
                } elsif ($arg->{argument}{_type}->kind() == tk_struct) {
                    my $struct = CORBA::ORB::_unmarshal_using_tc(\$reply, \$index, $byte_order, $arg->{argument}{_type});
                    %{$arg->{argument}{_value}} = %$struct;
                } else {
                    ${$arg->{argument}{_value}} = CORBA::ORB::_unmarshal_using_tc(\$reply, \$index, $byte_order, $arg->{argument}{_type});
                }
            }
        }
    } elsif ($reply_header->{reply_status} == GIOP::USER_EXCEPTION) {
        my $tc = CORBA::ORB::_id2package(CORBA::ORB::_unmarshal_string(\$reply, \$index, $byte_order));
        no strict 'refs';
        $tc = ${"${tc}::_tc"};
        my $exception = CORBA::ORB::_unmarshal_using_tc(\$reply, \$index, $byte_order, $tc);
        throw $exception;
        
    } elsif ($reply_header->{reply_status} == GIOP::SYSTEM_EXCEPTION) {
        die "System exception: " . CORBA::ORB::_unmarshal_string(\$reply, \$index, $byte_order);
    } else {
        die "Location forward";
    }
}

sub delete ($) {
    my($self) = @_;
}

sub send ($$) {
    my($self,$invoke_flags) = @_;
}

sub get_response ($$) {
    my($self,$response_flags) = @_;
}

# private methods

sub get_connection {
    my($self) = @_;
    my $peer = "$self->{host}:$self->{port}";
    my $connection = $CORBA::Request::connections{$peer};
    return $connection if $connection;
    my $error;
    # IO::Socket has a noisy way of reporting errors
    local $SIG{__WARN__} = sub { $error = 1 };
    $connection = IO::Socket::INET->new(
                    PeerAddr    => $peer,
                    Proto       => 'tcp');
    $error && throw(
        CORBA::COMM_FAILURE->new(minor => 0, completion_status => CORBA::CompletionStatus::COMPLETED_NO));
    return $CORBA::Request::connections{$peer} = $connection;
}

# private functions
1;
