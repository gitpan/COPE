# $Id: LName.pm,v 1.2 1997/07/31 11:03:31 schuller Exp $
# Copyright (c) 1997 Lunatech Research / Bart Schuller <schuller@lunatech.com>
# See the file "Artistic" in the distribution for licensing and
# (lack of) warranties.

use strict;
use COPE::CORBA::Exception;

package LNameComponent::NotSet;
use vars qw/@ISA/;
@ISA=qw/CORBA::UserException/;

package LNameComponent;
use vars qw/@ISA/;
@ISA=qw/CosNaming::NameComponent/;

sub id {
    my($self,$k) = @_;
    if (defined $k) {
        $self->{id} = $k;
    } else {
        if (defined $self->{id}) {
            return $self->{id};
        } else {
            throw LNameComponent::NotSet;
        }
    }
}

sub kind {
    my($self,$k) = @_;
    if (defined $k) {
        $self->{kind} = $k;
    } else {
        if (defined $self->{kind}) {
            return $self->{kind};
        } else {
            throw LNameComponent::NotSet;
        }
    }
}

package LName::InvalidName;
use vars qw/@ISA/;
@ISA=qw/CORBA::UserException/;

package LName;
use COPE::CosNaming_types;

sub new {
    my($class) = @_;
    my $self = [];
    return bless $self, $class;
}

sub insert_component {
    my($self, $i, $lnc) = @_;
    splice(@$self, $i-1, 0, new LNameComponent %$lnc);
    return $self;
}

sub get_component {
    my($self, $i) = @_;
    return $self->[$i-1];
}

sub delete_component {
    my($self, $i) = @_;
    return splice(@$self, $i-1, 1);
}

sub num_components {
    my($self) = @_;
    return scalar @$self;
}

sub equal {
    my($self, $ln) = @_;
    return 0 if @$self != @$ln;
    for (my $i=0; $i < @$self; $i++) {
        if (($self->[$i]->id ne $ln->[$i]->id) || ($self->[$i]->kind ne $ln->[$i]->kind)) {
            return 0;
        }
    }
    return 1;
}

sub less_than {
    my($self, $ln) = @_;
    my $nelem = @$self;
    if (@$ln < $nelem) {
        $nelem = @$ln;
    }
    for (my $i=0; $i < $nelem; $i++) {
        if ($self->[$i]->id lt $ln->[$i]->id) {
            return 1;
        }
    }
    return @$self < @$ln ? 1 : 0;
}

sub to_idl_form {
    my($self) = @_;
    if (!@$self) {
        throw LName::InvalidName;
    }
    my @name;
    foreach (@$self) {
        push @name, new CosNaming::NameComponent %$_;
    }
    return \@name;
}

sub from_idl_form {
    my($self, $n) = @_;
    @$self = map {new LNameComponent %$_} @$n;
}

1;
