# $Id: GIOP.pm,v 1.1.1.1 1997/05/17 11:47:05 schuller Exp $
# Copyright (c) 1997 Lunatech Research / Bart Schuller <schuller@lunatech.com>
# See the file "Artistic" in the distribution for licensing and
# (lack of) warranties.

use COPE::CORBA::ORB;

# module GIOP
package GIOP;

# enum MsgType
sub Request { 0 }
sub Reply { 1 }
sub CancelRequest { 2 }
sub LocateRequest { 3 }
sub LocateReply { 4 }
sub CloseConnection { 5 }
sub MessageError { 6 }

# struct Version
package GIOP::Version;
@ISA=qw(CORBA::_Struct);
sub _marshal {
    my($self) = pop; # sic
    CORBA::ORB::_marshal_char(@_, $self->{major});
    CORBA::ORB::_marshal_char(@_, $self->{minor});
}

sub _unmarshal {
    my $self = {};
    $self->{major} = CORBA::ORB::_unmarshal_char(@_);
    $self->{minor} = CORBA::ORB::_unmarshal_char(@_);
    return bless $self, 'GIOP::Version';
}

#$_tc = _create_struct_tc('', 'Version',
#    major           =>  $CORBA::_tc_char,
#    minor           =>  $CORBA::_tc_char,
#);

# struct MessageHeader
package GIOP::MessageHeader;
@ISA=qw(CORBA::_Struct);
# string, index, byte_order, self
sub _marshal {
    my($self) = pop; # sic
    CORBA::ORB::_marshal_char_array(@_, $self->{magic}, 4);
    GIOP::Version::_marshal(@_, $self->{GIOP_version});
    CORBA::ORB::_marshal_boolean(@_, $self->{byte_order});
    CORBA::ORB::_marshal_octet(@_, $self->{message_type});
    CORBA::ORB::_marshal_ulong(@_, $self->{message_size});
}

sub _unmarshal {
    my($byte_order_ref) = pop;
    my $self = {};
    $self->{magic} = CORBA::ORB::_unmarshal_char_array(@_, $$byte_order_ref, 4);
    $self->{GIOP_version} = GIOP::Version::_unmarshal(@_, $$byte_order_ref);
    $self->{byte_order} = CORBA::ORB::_unmarshal_boolean(@_, $$byte_order_ref);
    $$byte_order_ref = $self->{byte_order};
    $self->{message_type} = CORBA::ORB::_unmarshal_octet(@_, $$byte_order_ref);
    $self->{message_size} = CORBA::ORB::_unmarshal_ulong(@_, $$byte_order_ref);
    return bless $self, 'GIOP::MessageHeader';
}

#$_tc = _create_struct_tc('', 'MessageHeader',
#    magic           =>  create_array_tc(4, $CORBA::_tc_char),
#    GIOP_version    =>  $GIOP::Version::_tc,
#    byte_order      =>  $CORBA::_tc_boolean,
#    message_type    =>  $CORBA::_tc_octet,
#    message_size    =>  $CORBA::_tc_ulong,
#);

# struct RequestHeader
package GIOP::RequestHeader;
@ISA=qw(CORBA::_Struct);
sub _marshal {
    my($self) = pop; # sic
    CORBA::ORB::_marshal_sequence(@_, $self->{service_context}, \&IOP::ServiceContext::_marshal);
    CORBA::ORB::_marshal_ulong(@_, $self->{request_id});
    CORBA::ORB::_marshal_boolean(@_, $self->{response_expected});
    CORBA::ORB::_marshal_octet_sequence(@_, $self->{object_key});
    CORBA::ORB::_marshal_string(@_, $self->{operation});
    CORBA::ORB::_marshal_octet_sequence(@_, $self->{requesting_principal});
}

sub _unmarshal {
    my $self = {};
    $self->{service_context} = CORBA::ORB::_unmarshal_sequence(@_, \&IOP::ServiceContext::_unmarshal);
    $self->{request_id} = CORBA::ORB::_unmarshal_ulong(@_);
    $self->{response_expected} = CORBA::ORB::_unmarshal_boolean(@_);
    $self->{object_key} = CORBA::ORB::_unmarshal_octet_sequence(@_);
    $self->{operation} = CORBA::ORB::_unmarshal_string(@_);
    $self->{requesting_principal} = CORBA::ORB::_unmarshal_octet_sequence(@_);
    return bless $self, 'GIOP::RequestHeader';
}

#$_tc = _create_struct_tc('', 'RequestHeader',
#    service_context =>  $IOP::ServiceContextList::_tc,
#    request_id      =>  $CORBA::_tc_ulong,
#    response_expected   =>  $CORBA::_tc_boolean,
#    object_key      =>  create_sequence_tc(0,$CORBA::_tc_octet),
#    operation       =>  create_string_tc(0),
#    requesting_principal    =>  $CORBA::_tc_Principal,
#);

package GIOP;
# enum ReplyStatusType
sub NO_EXCEPTION () { 0 }
sub USER_EXCEPTION () { 1 }
sub SYSTEM_EXCEPTION () { 2 }
sub LOCATION_FORWARD () { 3 }

# struct ReplyHeader
package GIOP::ReplyHeader;
@ISA=qw(CORBA::_Struct);
sub _unmarshal {
    my $self = {};
    $self->{service_context} = CORBA::ORB::_unmarshal_sequence(
        @_, \&IOP::ServiceContext::_unmarshal);
    $self->{request_id} = CORBA::ORB::_unmarshal_ulong(@_);
    $self->{reply_status} = CORBA::ORB::_unmarshal_enum(@_);
    return bless $self, 'GIOP::ReplyHeader';
}

sub _marshal {
    my($self) = pop; # sic
    CORBA::ORB::_marshal_sequence(@_, $self->{service_context}, \&IOP::ServiceContext::_marshal);
    CORBA::ORB::_marshal_ulong(@_, $self->{request_id});
    CORBA::ORB::_marshal_enum(@_, $self->{reply_status});
}

1;
