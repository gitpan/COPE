# $Id: ServerRequest.pm,v 1.2 1997/05/21 11:28:06 schuller Exp $
# Copyright (c) 1997 Lunatech Research / Bart Schuller <schuller@lunatech.com>
# See the file "Artistic" in the distribution for licensing and
# (lack of) warranties.

# interface ServerRequest
package CORBA::ServerRequest;

sub new {
    my($class, $operation, $byte_order, $data, $index) = @_;
    my $self = {
        operation   =>  $operation,
        byte_order  =>  $byte_order,
        data        =>  $data,
        data_index  =>  $index,
    };
    return bless $self, $class;
}

sub params {
    my($self, $arg_list) = @_;
    $self->{arg_list} = $arg_list;
    my $index = $self->{data_index};
    for my $arg (@$arg_list) {
        if (($arg->{arg_modes}==0)||($arg->{arg_modes}==2)) {
            $arg->{argument}{_value} = CORBA::ORB::_unmarshal_using_tc(\$self->{data}, \$index, $self->{byte_order}, $arg->{argument}{_type});
        }
    }
}

sub result {
    my($self, $result) = @_;
    $self->{'result'} = $result;
}

sub op_name {
    my($self) = @_;
    return $self->{'operation'};
}

# not in interface

sub get_arglist {
    my($self) = @_;
    return $self->{arg_list};
}

sub get_result {
    my($self) = @_;
    return $self->{'result'};
}

1;
