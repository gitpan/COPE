# $Id: IOP.pm,v 1.2 1997/05/17 12:00:34 schuller Exp $
# Copyright (c) 1997 Lunatech Research / Bart Schuller <schuller@lunatech.com>
# See the file "Artistic" in the distribution for licensing and
# (lack of) warranties.

# module IOP
package IOP;
use COPE::CORBA::ORB;
use COPE::CORBA::TypeCode;

# const ProfileId TAG_INTERNET_IOP
sub TAG_INTERNET_IOP () { 0 }

$IOP::ServiceID_tc = _create_alias_tc('', 'ServiceID', $CORBA::_tc_ulong);
use strict;

# struct ServiceContext
package IOP::ServiceContext;
use COPE::CORBA::TypeCode;
@IOP::ServiceContext::ISA=qw(CORBA::_Struct);
sub _marshal {
    my($self) = pop; # sic
    CORBA::ORB::_marshal_ulong(@_, $self->{context_id});
    CORBA::ORB::_marshal_octet_sequence(@_, $self->{context_data});
}

$IOP::ServiceContext::_tc = _create_struct_tc('', 'ServiceContext',
    [
        context_id => $IOP::ServiceID_tc,
        context_data => _create_sequence_tc(0,$CORBA::_tc_octet)
    ]
);

# module IOP
package IOP;
use COPE::CORBA::TypeCode;
$IOP::ServiceContextList_tc = _create_alias_tc('',
    'ServiceContextList',
    _create_sequence_tc(0,$IOP::ServiceContext::_tc)
);
$IOP::TransactionService = \0;

# struct TaggedProfile
package IOP::TaggedProfile;
@IOP::TaggedProfile::ISA = qw(CORBA::_Struct);
sub _unmarshal {
    my $self = {};
    $self->{tag} = CORBA::ORB::_unmarshal_long(@_);
    $self->{profile_data} = CORBA::ORB::_unmarshal_octet_sequence(@_);
    return bless $self, 'IOP::TaggedProfile';
}

sub _marshal {
    my $self = pop; # sic
    CORBA::ORB::_marshal_long(@_, $self->{tag});
    CORBA::ORB::_marshal_octet_sequence(@_, $self->{profile_data});
}

# struct IOR
package IOP::IOR;
@IOP::IOR::ISA = qw(CORBA::_Struct);
sub _unmarshal {
    my $self = {};
    $self->{type_id} = CORBA::ORB::_unmarshal_string(@_);
    $self->{profiles} = CORBA::ORB::_unmarshal_sequence(
        @_, \&IOP::TaggedProfile::_unmarshal);
    return bless $self, 'IOP::IOR';
}

sub _marshal {
    my $self = pop; # sic
    CORBA::ORB::_marshal_string(@_, $self->{type_id}, length($self->{type_id}));
    CORBA::ORB::_marshal_sequence(@_, $self->{profiles}, \&IOP::TaggedProfile::_marshal);
}

# module IIOP
# struct Version
package IIOP::Version;
@IIOP::Version::ISA = qw(CORBA::_Struct);
sub _unmarshal {
    my $self = {};
    $self->{major} = CORBA::ORB::_unmarshal_char(@_);
    $self->{minor} = CORBA::ORB::_unmarshal_char(@_);
    return bless $self, 'IIOP::Version';
}

sub _marshal {
    my $self = pop; # sic
    CORBA::ORB::_marshal_char(@_, $self->{major});
    CORBA::ORB::_marshal_char(@_, $self->{minor});
}

# struct ProfileBody
package IIOP::ProfileBody;
@IIOP::ProfileBody::ISA = qw(CORBA::_Struct);
sub _unmarshal {
    my $self = {};
    $self->{iiop_version} = IIOP::Version::_unmarshal(@_);
    $self->{host} = CORBA::ORB::_unmarshal_string(@_);
    $self->{port} = CORBA::ORB::_unmarshal_ushort(@_);
    $self->{object_key} = CORBA::ORB::_unmarshal_octet_sequence(@_);
    return bless $self, 'IIOP::ProfileBody';
}

sub _marshal {
    my($self) = pop; # sic
    IIOP::Version::_marshal(@_, $self->{iiop_version});
    CORBA::ORB::_marshal_string(@_, $self->{host});
    CORBA::ORB::_marshal_ushort(@_, $self->{port});
    CORBA::ORB::_marshal_octet_sequence(@_, $self->{object_key});
}

1;
