# $Id: Object.pm,v 1.4 1997/06/19 14:34:40 schuller Exp $
# Copyright (c) 1997 Lunatech Research / Bart Schuller <schuller@lunatech.com>
# See the file "Artistic" in the distribution for licensing and
# (lack of) warranties.

use strict;

package CORBA::Object;
use COPE::GIOP;
use COPE::IOP;
use IO::Socket;
require COPE::CORBA::BOA;
require COPE::CORBA::Request;

$CORBA::Object::_tc = CORBA::TypeCode::_create_interface_tc('IDL:omg.org/CORBA/Object:1.0', 'Object');

sub _nil {
    return 0;
}

sub _new_from_ior {
    my($class, $ior, $orb) = @_;
    if (!defined $orb) {
        $orb = $CORBA::ORB::_The_Orb;
    }
    my $profile;
    foreach (@{$ior->{profiles}}) {
        if ($_->{tag} == 0) {
            $profile = $_->{profile_data};
        }
    }
    my $object = {_ior => $ior};
    if (defined $profile) {
        my $byte_order = unpack('C', substr($profile, 0, 1));
        my $index = 1;
        my $profilebody = IIOP::ProfileBody::_unmarshal(\$profile, \$index, $byte_order);
        $object->{orb} = $orb;
        @$object{qw(host port object_key)} = @$profilebody{qw(host port object_key)};
    }
    return bless $object, $class;
}

sub _narrow ($$) {
    my($class,$self) = @_;
    bless $self, $class;
    return $self;
}

sub is_nil {
    my($self) = @_;
    return !($self && ref($self) && exists($self->{host}));
}

sub create_request {
    my $self = shift;
    my $request = {@_};
    @$request{qw(orb host port object_key)} = @$self{qw(orb host port object_key)};
    return bless $request, 'CORBA::Request';
}

sub _attribute {
    my($self,$name,$type,$arg) = @_;
    my $result_ = { _type => defined $arg ? $CORBA::_tc_void : $type };
    my $arg_list = [];
    if (defined $arg) {
        push @$arg_list, 
            { 'argument'  =>
              { _type  => $type, _value => $arg },
              'arg_modes' => 0,
            };
    }
    my $opname = defined $arg ? '_set_' : '_get_';
    $opname .= $name;
    my $request_ = $self->create_request(
        'operation' => $opname,
        'arg_list'  => $arg_list,
        'result'    => $result_,
    );
    $request_->invoke(0);
    if (!defined $arg) {
        return $result_->{_value};
    }
}

1;

