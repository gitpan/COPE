# $Id: CosNaming_impl.pm,v 1.6 1997/07/31 11:03:29 schuller Exp $
# Copyright (c) 1997 Lunatech Research / Bart Schuller <schuller@lunatech.com>
# See the file "Artistic" in the distribution for licensing and
# (lack of) warranties.

use COPE::CosNaming_types;

# IDL:omg.org/CosNaming/NamingContext:1.0
package CosNaming::NamingContext_impl;
@CosNaming::NamingContext_impl::ISA=qw();
use COPE::CORBA::Exception;

sub new {
    my($class,@args) = @_;
    my $self = {};
    return bless $self, $class;
}

# IDL:omg.org/CosNaming/NamingContext/bind:1.0
sub bind {
    my($self,$n,$obj) = @_;
    my $component = pop @$n;
    if (scalar(@$n) > 0) {
        $self->resolve($n)->bind([$component], $obj);
    } else {
        $self->{'objects'}{$component->{'id'}} = [[$component], $obj];
    }
}

# IDL:omg.org/CosNaming/NamingContext/rebind:1.0
sub rebind {
    my($self,$n,$obj) = @_;
}

# IDL:omg.org/CosNaming/NamingContext/bind_context:1.0
sub bind_context {
    my($self,$n,$nc) = @_;
    my $component = pop @$n;
    if (scalar(@$n) > 0) {
        $self->resolve($n)->bind_context([$component], $nc);
    } else {
        $self->{'contexts'}{$component->{'id'}} = [[$component], $nc];
    }
}

# IDL:omg.org/CosNaming/NamingContext/rebind_context:1.0
sub rebind_context {
    my($self,$n,$nc) = @_;
}

# IDL:omg.org/CosNaming/NamingContext/resolve:1.0
sub resolve {
    my($self,$n) = @_;
    if (!@$n) {
        throw CosNaming::NamingContext::InvalidName;
    }
    my $c = pop @$n;
    my $o;
    if (exists $self->{'contexts'}{$c->{'id'}}) {
        $o = $self->{'contexts'}{$c->{'id'}}[1];
    }
    if (defined $o) {
        return @$n ? $o->resolve($n) : $o;
    }
    if (exists $self->{'objects'}{$c->{'id'}}) {
        $o = $self->{'objects'}{$c->{'id'}}[1];
    }
    if (defined $o) {
        if (!@$n) {
            return $o;
        } else {
            throw new CosNaming::NamingContext::NotFound
                why => CosNaming::NamingContext::NotFoundReason::not_context,
                rest_of_name => $n;
        }
    }
    throw new CosNaming::NamingContext::NotFound
                why => CosNaming::NamingContext::NotFoundReason::missing_node,
                rest_of_name => [$c];
}

# IDL:omg.org/CosNaming/NamingContext/unbind:1.0
sub unbind {
    my($self,$n) = @_;
}

# IDL:omg.org/CosNaming/NamingContext/new_context:1.0
sub new_context {
    my($self) = @_;
    return CosNaming::NamingContext_skel->new();
}

# IDL:omg.org/CosNaming/NamingContext/bind_new_context:1.0
sub bind_new_context {
    my($self,$n) = @_;
    my $ctx = $self->new_context();
    $self->bind_context($n, $ctx);
    return $ctx;
}

# IDL:omg.org/CosNaming/NamingContext/destroy:1.0
sub destroy {
    my($self) = @_;
}

# IDL:omg.org/CosNaming/NamingContext/list:1.0
sub list {
    my($self,$how_many,$bl,$bi) = @_;
    my $bindinglist = [ map { CosNaming::Binding->new(
            binding_name => $_->[0],
            binding_type => CosNaming::BindingType::ncontext
                      ) } values %{$self->{'contexts'}} ];
    push @$bindinglist, map { CosNaming::Binding->new(
            binding_name => $_->[0],
            binding_type => CosNaming::BindingType::nobject
                      ) } values %{$self->{'objects'}};
    push @$bl, @$bindinglist;
    $$bi = CORBA::Object->_nil();
}

# IDL:omg.org/CosNaming/BindingIterator:1.0
package CosNaming::BindingIterator_impl;
@CosNaming::BindingIterator_impl::ISA=qw();
sub new {
    my($class,@args) = @_;
    my $self = {};
    return bless $self, $class;
}

# IDL:omg.org/CosNaming/BindingIterator/next_one:1.0
sub next_one {
    my($self,$b) = @_;
}

# IDL:omg.org/CosNaming/BindingIterator/next_n:1.0
sub next_n {
    my($self,$how_many,$bl) = @_;
}

# IDL:omg.org/CosNaming/BindingIterator/destroy:1.0
sub destroy {
    my($self) = @_;
}


1;
