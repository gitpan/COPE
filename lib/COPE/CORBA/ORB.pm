# $Id: ORB.pm,v 1.7 1997/07/25 10:12:42 schuller Exp $
# Copyright (c) 1997 Lunatech Research / Bart Schuller <schuller@lunatech.com>
# See the file "Artistic" in the distribution for licensing and
# (lack of) warranties.

use Carp;
# interface ORB
package CORBA::ORB;
$CORBA::ORB::_The_Orb = 0;
use strict;
use COPE::CORBA::TypeCode;
use COPE::CORBA::TCKind;
use COPE::CORBA::BOA;
use COPE::CORBA::Exception;

my $_byte_order;

BEGIN {
    if (pack('N', 1) eq pack('L', 1)) {
        $_byte_order = 0;
    } else {
        $_byte_order = 1;
    }
}

sub new {
    my($class,$argv,$orb_identifier) = @_;
    my $self = {
	    byte_order  =>  $_byte_order,
    };

    #
    # Check for -ORBport argument and remove it from
    # the list of arguments.
    #
    if (defined($argv)) {
        my $x;
        for ($x=0; $x < $#$argv; $x++) {
            if ($argv->[$x] eq '-ORBport') {
                my $orbport = $argv->[$x+1];
                $orbport =~ s/\D//g;
                splice(@$argv, $x, 2);
                if ($orbport){
                    $self->{port} = $orbport;
                }
            }
        }
    }
       
    return $CORBA::ORB::_The_Orb = bless $self, $class;
}

sub _marshal_boolean {
    my($out, $index, $byte_order, $data) = @_;
    $$out.= $data ? "\1" : "\0";
    $$index++;
}

sub _marshal_octet {
    my($out, $index, $byte_order, $data) = @_;
    $$out .= pack('C', $data);
    $$index++;
}

sub _marshal_char {
    my($out, $index, $byte_order, $data) = @_;
    $$out .= pack('a', $data);
    $$index++;
}

sub _marshal_ushort {
    my($out, $index, $byte_order, $data) = @_;
    my $previndex = $$index;
    $$index = (1+$$index)& ~1;
    $$out .= "\0" x ($$index-$previndex) . pack($byte_order ? 'v' : 'n', $data);
    $$index += 2;
}

sub _marshal_short { _marshal_ushort(@_) }

sub _marshal_ulong {
    my($out, $index, $byte_order, $data) = @_;
    my $previndex = $$index;
    $$index = (3+$$index)& ~3;
    $$out .= "\0" x ($$index-$previndex) . pack($byte_order ? 'V' : 'N', $data);
    $$index += 4;
}

sub _marshal_long { _marshal_ulong(@_) }

sub _marshal_enum { _marshal_ulong(@_) }

sub _marshal_octet_array {
    my($out, $index, $byte_order, $data, $length) = @_;
    $$out .= pack("a$length", $data);
    $$index += $length;
}

sub _marshal_char_array { _marshal_octet_array(@_) }

sub _marshal_string {
    my($out, $index, $byte_order, $data, $length) = @_;
    $data .= "\0";
    _marshal_ulong($out, $index, $byte_order, length($data));
    $$out .= $data;
    $$index += length($data);
}

sub _marshal_octet_sequence {
    my($out, $index, $byte_order, $data, $length) = @_;
    _marshal_ulong($out, $index, $byte_order, length($data));
    $$out .= $data;
    $$index += length($data);
}

sub _marshal_sequence {
    my($out, $index, $byte_order, $data, $_marshal, @extra) = @_;
    _marshal_ulong($out, $index, $byte_order, scalar(@$data));
    foreach my $item (@$data) {
        &$_marshal($out, $index, $byte_order, $item, @extra);
    }
}

sub _unmarshal_string {
    my($in, $index, $byte_order) = @_;
    $$index = (3+$$index)& ~3;
    my $length = unpack($byte_order ? 'V' : 'N', substr($$in,$$index,4));
    $$index += 4;
    my $string = substr($$in, $$index, $length - 1);
    $$index += $length;
    return $string;
}

sub _unmarshal_octet_sequence {
    my($in, $index, $byte_order) = @_;
    $$index = (3+$$index)& ~3;
    my $length = unpack($byte_order ? 'V' : 'N', substr($$in,$$index,4));
    $$index += 4;
    my $string = substr($$in, $$index, $length);
    $$index += $length;
    return $string;
}

sub _unmarshal_char {
    my($in, $index, $byte_order) = @_;
    return substr($$in,$$index++,1);
}

sub _unmarshal_octet {
    my($in, $index, $byte_order) = @_;
    return unpack('C', substr($$in,$$index++,1));
}

sub _unmarshal_boolean { _unmarshal_octet(@_) }

sub _unmarshal_octet_array {
    my($in, $index, $byte_order, $length) = @_;
    my $oldindex = $$index;
    $$index += $length;
    return substr($$in,$oldindex,$length);
}

sub _unmarshal_char_array { _unmarshal_octet_array(@_) }

sub _unmarshal_ushort {
    my($in, $index, $byte_order) = @_;
    $$index = (1+$$index)& ~1;
    my $short = unpack($byte_order ? 'v' : 'n', substr($$in,$$index,2));
    $$index += 2;
    return $short;
}

sub _unmarshal_short {
    my($in, $index, $byte_order) = @_;
    $$index = (1+$$index)& ~1;
    my $tmp = substr($$in,$$index,2);
    if ($byte_order xor $_byte_order) {
        $tmp = pack('v', unpack('n', $tmp));
    }
    my $short = unpack('s', $tmp);
    $$index += 2;
    return $short;
}

sub _unmarshal_ulong {
    my($in, $index, $byte_order) = @_;
    $$index = (3+$$index)& ~3;
    my $long = unpack($byte_order ? 'V' : 'N', substr($$in,$$index,4));
    $$index += 4;
    return $long;
}

sub _unmarshal_long {
    my($in, $index, $byte_order) = @_;
    $$index = (3+$$index)& ~3;
    my $tmp = substr($$in,$$index,4);
    if ($byte_order xor $_byte_order) {
        $tmp = pack('V', unpack('N', $tmp));
    }
    my $long = unpack('l', $tmp);
    $$index += 4;
    return $long;
}

sub _unmarshal_enum { _unmarshal_ulong(@_) }

sub _unmarshal_sequence {
    my($in, $index, $byte_order, $_unmarshal, @extra) = @_;
    $$index = (3+$$index)& ~3;
    my $num = unpack($byte_order ? 'V' : 'N', substr($$in,$$index,4));
    $$index += 4;
    my @self = ();
    for (my $c = 0; $c < $num; $c++) {
       push @self, &$_unmarshal($in, $index, $byte_order, @extra);
    }
    return \@self;
}

sub _id2package {
    my($id) = @_;
    if ($id =~ m!^IDL:([^/]+/)?(.+):.+$!) {
        my $package = $2;
        $package =~ s!/!::!g;
        return $package;
    } else {
        die "_id2package: $id is not a proper RepositoryId";
    }
}

BEGIN { $::marshal_depth=0 }

sub _marshal_using_tc {
    my $tc = pop; # sic
    my $kind = $tc->kind;
    if ($kind == tk_short) {
        _marshal_short(@_);
        return;
    }
    if ($kind == tk_boolean) {
        _marshal_boolean(@_);
        return;
    }
    if ($kind == tk_long) {
        _marshal_long(@_);
        return;
    }
    if ($kind == tk_ulong) {
        _marshal_ulong(@_);
        return;
    }
    if ($kind == tk_enum) {
        _marshal_enum(@_);
        return;
    }
    if ($kind == tk_string) {
        _marshal_string(@_, $tc->length());
        return;
    }
    if ($kind == tk_sequence) {
        my $ct = $tc->content_type();
        if ($ct->kind() == tk_octet) {
            _marshal_octet_sequence(@_, $tc->length());
            return;
        }
        my $seq = pop;
        _marshal_ulong(@_, scalar(@$seq));
        foreach my $item (@$seq) {
            _marshal_using_tc(@_, $item, $ct);
        }
        return;
    }
    if ($kind == tk_objref) {
        my $obj = pop;
        IOP::IOR::_marshal(@_, $CORBA::ORB::_The_Orb->_object_to_IOR($obj));
        return;
    }
    if ($kind == tk_struct) {
        my $struct = pop;
        my $count = $tc->member_count;
        for (my $counter = 0; $counter < $count; $counter++) {
	    my $element = $struct->{$tc->member_name($counter)};
	    if (!defined($element)) {
		throw new CORBA::MARSHAL minor => $counter, completion_status => CORBA::CompletionStatus::COMPLETED_MAYBE;
	    }
            _marshal_using_tc(@_, $element, $tc->member_type($counter));
        }
        return;
    }
    if ($kind == tk_array) {
        my $ct = $tc->content_type();
        if ($ct->kind() == tk_octet) {
            _marshal_octet_array(@_, $tc->length());
            return;
        }
        my $array = pop;
        for(my $i=0;$i < $tc->length();$i++) {
            _marshal_using_tc(@_, $array->[$i], $ct);
        }
        return;
    }
    if ($kind == tk_except) {
        my $except = pop;
        my $count = $tc->member_count;
        _marshal_string(@_, $tc->id(), 0);
        for (my $counter = 0; $counter < $count; $counter++) {
            _marshal_using_tc(@_, $except->{$tc->member_name($counter)}, $tc->member_type($counter));
        }
        return;
    }
    die "Kind $kind not implemented";
}

sub _unmarshal_using_tc {
    my($inref, $indexref, $byte_order, $tc) = @_;
    my $kind = $tc->kind;

    if ($kind == tk_void) { return }
    if ($kind == tk_short) {
        return _unmarshal_short($inref, $indexref, $byte_order);
    }
    if ($kind == tk_long) {
        return _unmarshal_long($inref, $indexref, $byte_order);
    }
    if ($kind == tk_ulong) {
        return _unmarshal_ulong($inref, $indexref, $byte_order);
    }
    if ($kind == tk_boolean) {
        return _unmarshal_boolean($inref, $indexref, $byte_order);
    }
    if ($kind == tk_struct) {
        my $result = {};
        my $count = $tc->member_count;
        for (my $counter = 0; $counter < $count; $counter++) {
            $result->{$tc->member_name($counter)} = _unmarshal_using_tc(
                $inref, $indexref, $byte_order, $tc->member_type($counter));
        }
        return bless $result, CORBA::ORB::_id2package($tc->id);
    }
    if ($kind == tk_sequence) {
        my $ct = $tc->content_type();
        if ($ct->kind() == tk_octet) {
            return _unmarshal_octet_sequence($inref, $indexref, $byte_order);
        }
        my $result = [];
        my $count = _unmarshal_ulong($inref, $indexref, $byte_order);
        for (my $counter = 0; $counter < $count; $counter++) {
            $result->[$counter] = _unmarshal_using_tc(
                $inref, $indexref, $byte_order, $ct);
        }
        return $result;
    }
    if ($kind == tk_array) {
        my $ct = $tc->content_type();
        my $count = $tc->length();
        if ($ct->kind() == tk_octet) {
            return _unmarshal_octet_array($inref, $indexref, $byte_order, $count);
        }
        my $result = [];
        for (my $counter = 0; $counter < $count; $counter++) {
            $result->[$counter] = _unmarshal_using_tc(
                $inref, $indexref, $byte_order, $ct);
        }
        return $result;
    }
    if ($kind == tk_string) {
        return _unmarshal_string($inref, $indexref, $byte_order);
    }
    if ($kind == tk_TypeCode) {
        return CORBA::TypeCode::_unmarshal($inref, $indexref, $byte_order);
    }
    if ($kind == tk_enum) {
        return _unmarshal_enum($inref, $indexref, $byte_order);
    }
    if ($kind == tk_objref) {
        my $ior = IOP::IOR::_unmarshal($inref, $indexref, $byte_order);
        my $object = CORBA::Object->_new_from_ior($ior);
        return bless $object, CORBA::ORB::_id2package($tc->id);
    }
    if ($kind == tk_except) {
        my $result = {};
        my $count = $tc->member_count;
        for (my $counter = 0; $counter < $count; $counter++) {
            $result->{$tc->member_name($counter)} = _unmarshal_using_tc(
                $inref, $indexref, $byte_order, $tc->member_type($counter));
        }
        return bless $result, CORBA::ORB::_id2package($tc->id);
    }
    if ($kind == tk_any) {
        my $result = {_type  => CORBA::TypeCode::_unmarshal($inref, $indexref, $byte_order) };
        $result->{_value} = _unmarshal_using_tc($inref, $indexref, $byte_order, $result->{_type});
        return $result;
    }
    die "Kind $kind not implemented";
}

sub BOA_init (;$$) {
    return new CORBA::BOA @_;
}

use COPE::IOP;
use COPE::CORBA::Object;

sub _object_to_IOR {
    my($self,$impl) = @_;
    my $ior;
    if ($impl) {
        if ("$impl" =~ /=HASH/ && $impl->{_ior}) {
            return $impl->{_ior}; # impl is really a client-side stub Object
                                  # TODO use UNIVERSAL?
        }
        my $boa = $CORBA::BOA::_The_Boa;
        my $obj = $boa->{skeletons}{$impl};
        if ($obj->{_ior}) {
            return $obj->{_ior};
        }
        my $profilebody = new IIOP::ProfileBody (
            iiop_version    =>  new IIOP::Version (major=>chr(1),minor=>chr(0)),
            host            =>  $boa->{host},
            port            =>  $boa->{port},
            object_key      =>  $obj->{id}      );
        my $profile_data = chr($boa->{byte_order});
        my $index = 1;
        IIOP::ProfileBody::_marshal(\$profile_data, \$index, $boa->{byte_order}, $profilebody);
        my $taggedprofile = new IOP::TaggedProfile (
            tag             =>  IOP::TAG_INTERNET_IOP,
            profile_data    =>  $profile_data );
        $ior = new IOP::IOR (
            type_id         =>  $obj->{interface},
            profiles        =>  [ $taggedprofile ] );
        $obj->{_ior} = $ior;
    } else {
        $ior = new IOP::IOR (
            type_id         => '',
            profiles        => [] );
    }
    return $ior;
}

sub object_to_string {
    my($self,$impl) = @_;
    my $boa = $CORBA::BOA::_The_Boa;
    my $m_ior = chr($boa->{byte_order});
    my $ior = $self->_object_to_IOR($impl);
    my $index = 1;
    IOP::IOR::_marshal(\$m_ior, \$index, $boa->{byte_order}, $ior);
    my $hex = 'IOR:';
    for (my $i = 0; $i < length($m_ior); $i++) {
        $hex .= sprintf("%02X", unpack('C', substr($m_ior, $i, 1)));
    }
    return $hex;
}

sub string_to_object {
    my($self,$str) = @_;
    my $hex = substr($str,4);
    my $m_ior = '';
    for (my $i = 0; $i < length($hex); $i += 2) {
        $m_ior .= pack('C', hex(join('',unpack('aa', substr($hex, $i, 2)))));
    }
    my $byte_order = unpack('C', substr($m_ior, 0, 1));
    # skip first byte
    my $index = 1;
    my $ior = IOP::IOR::_unmarshal(\$m_ior, \$index, $byte_order);
    return CORBA::Object->_new_from_ior($ior, $self);
}

sub list_initial_services {
    return [ qw/
        NameService
        InterfaceRepository
    /];
}

require COPE::Announcer;

sub resolve_initial_references {
    my($self, $objectid) = @_;
    return $self->string_to_object(COPE::Announcer::resolve($objectid));
}

package CORBA::_Struct;

sub new ($%) {
    my($class, %self) = @_;
    bless \%self, $class;
}

package CORBA;

sub ORB_init (;$$) {
    return new CORBA::ORB @_;
}

1;
