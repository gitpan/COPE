# $Id: TypeCode.pm,v 1.1.1.1 1997/05/17 11:47:05 schuller Exp $
# Copyright (c) 1997 Lunatech Research / Bart Schuller <schuller@lunatech.com>
# See the file "Artistic" in the distribution for licensing and
# (lack of) warranties.

package COPE::CORBA::TypeCode;
sub import {
    shift;
    my $callpkg = caller(0);
    CORBA::TypeCode->export($callpkg, @_);
}

# interface TypeCode // PIDL
package CORBA::TypeCode;
use strict;
require Exporter;
@CORBA::TypeCode::ISA = qw(Exporter);
@CORBA::TypeCode::EXPORT = qw(
                _create_struct_tc _create_union_tc _create_enum_tc
                _create_alias_tc _create_exception_tc _create_interface_tc
                _create_string_tc _create_sequence_tc
                _create_recursive_sequence_tc _create_array_tc
            );
use COPE::CORBA::TCKind;
@CORBA::_tc_basic = (
    $CORBA::_tc_null = CORBA::TypeCode->_new_basic(tk_null),
    $CORBA::_tc_void = CORBA::TypeCode->_new_basic(tk_void),
    $CORBA::_tc_short = CORBA::TypeCode->_new_basic(tk_short),
    $CORBA::_tc_long = CORBA::TypeCode->_new_basic(tk_long),
    $CORBA::_tc_ushort = CORBA::TypeCode->_new_basic(tk_ushort),
    $CORBA::_tc_ulong = CORBA::TypeCode->_new_basic(tk_ulong),
    $CORBA::_tc_float = CORBA::TypeCode->_new_basic(tk_float),
    $CORBA::_tc_double = CORBA::TypeCode->_new_basic(tk_double),
    $CORBA::_tc_boolean = CORBA::TypeCode->_new_basic(tk_boolean),
    $CORBA::_tc_char = CORBA::TypeCode->_new_basic(tk_char),
    $CORBA::_tc_octet = CORBA::TypeCode->_new_basic(tk_octet),
    $CORBA::_tc_any = CORBA::TypeCode->_new_basic(tk_any),
    $CORBA::_tc_TypeCode = CORBA::TypeCode->_new_basic(tk_TypeCode),
    $CORBA::_tc_Principal = CORBA::TypeCode->_new_basic(tk_Principal),
);

my(%has_id_and_name) = map { $_ => 1 } (tk_objref, tk_struct, tk_union, tk_enum, tk_alias, tk_except);
my(%has_members) = map { $_ => 1 } (tk_struct, tk_union, tk_enum, tk_except);
my(%has_type) = map { $_ => 1 } (tk_sequence, tk_array, tk_alias);
my(%has_length) = map { $_ => 1 } (tk_sequence, tk_array);

sub _new_basic {
    my($class, $tk) = @_;
    return bless {_kind => $tk}, $class;
}

sub _unmarshal {
    my $kind = CORBA::ORB::_unmarshal_ulong(@_);
    my $self = {};
    if ($kind <= 13) {
        return $CORBA::_tc_basic[$kind];
    } else {
        $self->{_kind} = $kind;
    }
    if ($self->{_kind} == 0xffffffff) {
        die "CORBA::TypeCode::_unmarshal got an indirection: " . CORBA::ORB::_unmarshal_ulong(@_);
    } elsif ($self->{_kind} == tk_string) {
        $self->{_length} = CORBA::ORB::_unmarshal_ulong(@_);
    } else {
#
# if we get here, we have parameters in "complex" encoding.
#
        my($byte_order) = $_[2]; 
        my($cdrin, $index) = ('', 0);
        $cdrin = CORBA::ORB::_unmarshal_octet_sequence(@_);
        @_ = (\$cdrin, \$index, $byte_order);
        $byte_order = $_[2] = CORBA::ORB::_unmarshal_boolean(@_);
        if ($has_id_and_name{$self->{_kind}}) {
            $self->{_id} = CORBA::ORB::_unmarshal_string(@_);
            $self->{_name} = CORBA::ORB::_unmarshal_string(@_);
        }
        if ($self->{_kind} == tk_union) {
            $self->{_discriminator_type} = CORBA::TypeCode::_unmarshal(@_);
            $self->{_default_index} = CORBA::ORB::_unmarshal_long(@_);
        }
        if ($has_members{$self->{_kind}}) {
            my($count) = CORBA::ORB::_unmarshal_ulong(@_);
            $self->{_members} = [];
            if ($self->{_kind} == tk_enum) {
                while ($count--) {
                    push @{$self->{_members}}, {_name => CORBA::ORB::_unmarshal_string(@_)};
                }
            } elsif (($self->{_kind} == tk_struct) || ($self->{_kind} == tk_except)) {
                while ($count--) {
                    my $member = {};
                    $member->{_name} = CORBA::ORB::_unmarshal_string(@_);
                    $member->{_type} = CORBA::TypeCode::_unmarshal(@_);
                    push @{$self->{_members}}, $member;
                }
            } elsif ($self->{_kind} == tk_union) {
                while ($count--) {
                    my $member = {};
                    if ($self->{_discriminator_type}->kind == tk_short) {
                        $member->{_label} = CORBA::ORB::_unmarshal_short(@_);
                    } elsif ($self->{_discriminator_type}->kind == tk_ushort) {
                        $member->{_label} = CORBA::ORB::_unmarshal_ushort(@_);
                    } elsif ($self->{_discriminator_type}->kind == tk_long) {
                        $member->{_label} = CORBA::ORB::_unmarshal_long(@_);
                    } elsif ($self->{_discriminator_type}->kind == tk_ulong) {
                        $member->{_label} = CORBA::ORB::_unmarshal_ulong(@_);
                    } elsif ($self->{_discriminator_type}->kind == tk_boolean) {
                        $member->{_label} = CORBA::ORB::_unmarshal_boolean(@_);
                    } elsif ($self->{_discriminator_type}->kind == tk_char) {
                        $member->{_label} = CORBA::ORB::_unmarshal_char(@_);
                    } elsif ($self->{_discriminator_type}->kind == tk_enum) {
                        $member->{_label} = CORBA::ORB::_unmarshal_enum(@_);
                    }
                    $member->{_name} = CORBA::ORB::_unmarshal_string(@_);
                    $member->{_type} = CORBA::TypeCode::_unmarshal(@_);
                    push @{$self->{_members}}, $member;
                }
            }
        } elsif ($has_type{$self->{_kind}}) {
            $self->{_type} = CORBA::TypeCode::_unmarshal(@_);
        }
        if ($has_length{$self->{_kind}}) {
            $self->{_length} = CORBA::ORB::_unmarshal_ulong(@_);
        }
    }
    return bless $self, 'CORBA::TypeCode';
}

sub kind {
    my($self) = @_;
    return $self->{_kind};
}

sub id {
    my($self) = @_;
    return $self->{_id};
}

sub name {
    my($self) = @_;
    return $self->{_name};
}

sub content_type {
    my($self) = @_;
    return $self->{_type};
}

sub member_count {
    my($self) = @_;
    return scalar @{$self->{_members}};
}

sub member_name {
    my($self, $index) = @_;
    return $self->{_members}[$index]{_name};
}

sub member_type {
    my($self, $index) = @_;
    return $self->{_members}[$index]{_type};
}

sub length {
    my($self) = @_;
    return $self->{_length};
}

sub _create_alias_tc ($$$) {
    my($id,$name,$original_type) = @_;
    my $tc = {  _kind   =>  tk_alias,
                _id     =>  $id,
                _name   =>  $name,
                _type   =>  $original_type,
            };
    return bless $tc, 'CORBA::TypeCode';
}

sub _create_struct_tc ($$$) {
    my($id,$name,$members) = @_;
    my $tc = {  _kind       =>  tk_struct,
                _id         =>  $id,
                _name       =>  $name,
                _members    =>  [],
            };
    my @members = @$members;
    while (my($n,$t) = splice(@members, 0, 2)) {
        push @{$tc->{_members}}, {_name => $n, _type => $t};
    }
    return bless $tc, 'CORBA::TypeCode';
}

sub _create_exception_tc ($$$) {
    my($id,$name,$members) = @_;
    my $tc = {  _kind       =>  tk_except,
                _id         =>  $id,
                _name       =>  $name,
                _members    =>  [],
            };
    my @members = @$members;
    while (my($n,$t) = splice(@members, 0, 2)) {
        push @{$tc->{_members}}, {_name => $n, _type => $t};
    }
    return bless $tc, 'CORBA::TypeCode';
}

sub _create_enum_tc ($$$) {
    my($id,$name,$members) = @_;
    my $tc = {  _kind       =>  tk_enum,
                _id         =>  $id,
                _name       =>  $name,
                _members    =>  $members,
            };
    return bless $tc, 'CORBA::TypeCode';
}

sub _create_sequence_tc ($$) {
    my($bound,$element_type) = @_;
    my $tc = {  _kind       =>  tk_sequence,
                _length     =>  $bound,
                _type       =>  $element_type,
            };
    return bless $tc, 'CORBA::TypeCode';
}

sub _create_array_tc ($$) {
    my($bound,$element_type) = @_;
    my $tc = {  _kind       =>  tk_array,
                _length     =>  $bound,
                _type       =>  $element_type,
            };
    return bless $tc, 'CORBA::TypeCode';
}

sub _create_string_tc ($) {
    my($bound) = @_;
    my $tc = {  _kind       =>  tk_string,
                _length     =>  $bound,
            };
    return bless $tc, 'CORBA::TypeCode';
}

sub _create_interface_tc ($$) {
    my($id, $name) = @_;
    my $tc = {  _kind       =>  tk_objref,
                _id         =>  $id,
                _name       =>  $name,
            };
    return bless $tc, 'CORBA::TypeCode';
}

sub _noalias_kind {
    my($self) = @_;
    while ($self->kind() == tk_alias) {
        $self = $self->content_type();
    }
    return $self->kind();
}

sub _noalias_content_type {
    my($self) = @_;
    while ($self->kind() == tk_alias) {
        $self = $self->content_type();
    }
    return $self->content_type();
}

sub _needs_ref ($$) {
    my($self, $mode) = @_;

    return 0 if $mode == 0; # in parameters never need pass by reference
    my $kind = $self->kind();
    if (($kind <= tk_octet) || ($kind == tk_Principal) || ($kind == tk_enum) ||
        ($kind == tk_string)) {
        return 1;
    }
    if ($kind == tk_alias) {
        return $self->content_type->_needs_ref($mode);
    }
    if (($kind == tk_sequence) && ($self->content_type()->kind() == tk_octet)) {
        return 1; # octet-sequence implemented as a scalar
    }
    return 0;
}

1;

__END__

