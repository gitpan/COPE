# Automatically generated skeleton code, MODIFICATIONS WILL BE LOST.
# Generated on Thu Jun  5 21:37:55 1997 with the following command:
# /opt/perl/bin/idl2perl --impl Naming.idl

use COPE::CosNaming_types;
use COPE::CosNaming_impl;

# IDL:omg.org/CosNaming/NamingContext:1.0
package CosNaming::NamingContext_skel;
push @CosNaming::NamingContext_impl::ISA, 'CORBA::Object';
@CosNaming::NamingContext_skel::ISA=qw(CORBA::Object);
$CosNaming::NamingContext_skel::_id = 0;

sub new {
    my($class,@args) = @_;
    my $impl = CosNaming::NamingContext_impl->new(@args);
    my $self = bless $CORBA::BOA::_The_Boa->_create('IDL:omg.org/CosNaming/NamingContext:1.0 ' . $CosNaming::NamingContext_skel::_id++, 'IDL:omg.org/CosNaming/NamingContext:1.0', $impl), $class;
    return $impl;
}

# IDL:omg.org/CosNaming/NamingContext/bind:1.0
sub bind {
    my($self,$serverrequest) = @_;
    my $arg_list = [
        { 'argument'  =>
          { _type  => $CosNaming::Name::_tc },
          'arg_modes' => 0,
        },
        { 'argument'  =>
          { _type  => $CORBA::Object::_tc },
          'arg_modes' => 0,
        },
    ];
    $serverrequest->params($arg_list);
    $self->{impl}->bind(
        $arg_list->[0]{argument}{_value},
        $arg_list->[1]{argument}{_value},
    );
}

# IDL:omg.org/CosNaming/NamingContext/rebind:1.0
sub rebind {
    my($self,$serverrequest) = @_;
    my $arg_list = [
        { 'argument'  =>
          { _type  => $CosNaming::Name::_tc },
          'arg_modes' => 0,
        },
        { 'argument'  =>
          { _type  => $CORBA::Object::_tc },
          'arg_modes' => 0,
        },
    ];
    $serverrequest->params($arg_list);
    $self->{impl}->rebind(
        $arg_list->[0]{argument}{_value},
        $arg_list->[1]{argument}{_value},
    );
}

# IDL:omg.org/CosNaming/NamingContext/bind_context:1.0
sub bind_context {
    my($self,$serverrequest) = @_;
    my $arg_list = [
        { 'argument'  =>
          { _type  => $CosNaming::Name::_tc },
          'arg_modes' => 0,
        },
        { 'argument'  =>
          { _type  => $CosNaming::NamingContext::_tc },
          'arg_modes' => 0,
        },
    ];
    $serverrequest->params($arg_list);
    $self->{impl}->bind_context(
        $arg_list->[0]{argument}{_value},
        $arg_list->[1]{argument}{_value},
    );
}

# IDL:omg.org/CosNaming/NamingContext/rebind_context:1.0
sub rebind_context {
    my($self,$serverrequest) = @_;
    my $arg_list = [
        { 'argument'  =>
          { _type  => $CosNaming::Name::_tc },
          'arg_modes' => 0,
        },
        { 'argument'  =>
          { _type  => $CosNaming::NamingContext::_tc },
          'arg_modes' => 0,
        },
    ];
    $serverrequest->params($arg_list);
    $self->{impl}->rebind_context(
        $arg_list->[0]{argument}{_value},
        $arg_list->[1]{argument}{_value},
    );
}

# IDL:omg.org/CosNaming/NamingContext/resolve:1.0
sub resolve {
    my($self,$serverrequest) = @_;
    my $result_ = { _type => $CORBA::Object::_tc };
    my $arg_list = [
        { 'argument'  =>
          { _type  => $CosNaming::Name::_tc },
          'arg_modes' => 0,
        },
    ];
    $serverrequest->params($arg_list);
    $serverrequest->result($result_);
    $result_->{_value} = $self->{impl}->resolve(
        $arg_list->[0]{argument}{_value},
    );
}

# IDL:omg.org/CosNaming/NamingContext/unbind:1.0
sub unbind {
    my($self,$serverrequest) = @_;
    my $arg_list = [
        { 'argument'  =>
          { _type  => $CosNaming::Name::_tc },
          'arg_modes' => 0,
        },
    ];
    $serverrequest->params($arg_list);
    $self->{impl}->unbind(
        $arg_list->[0]{argument}{_value},
    );
}

# IDL:omg.org/CosNaming/NamingContext/new_context:1.0
sub new_context {
    my($self,$serverrequest) = @_;
    my $result_ = { _type => $CosNaming::NamingContext::_tc };
    my $arg_list = [
    ];
    $serverrequest->params($arg_list);
    $serverrequest->result($result_);
    $result_->{_value} = $self->{impl}->new_context(
    );
}

# IDL:omg.org/CosNaming/NamingContext/bind_new_context:1.0
sub bind_new_context {
    my($self,$serverrequest) = @_;
    my $result_ = { _type => $CosNaming::NamingContext::_tc };
    my $arg_list = [
        { 'argument'  =>
          { _type  => $CosNaming::Name::_tc },
          'arg_modes' => 0,
        },
    ];
    $serverrequest->params($arg_list);
    $serverrequest->result($result_);
    $result_->{_value} = $self->{impl}->bind_new_context(
        $arg_list->[0]{argument}{_value},
    );
}

# IDL:omg.org/CosNaming/NamingContext/destroy:1.0
sub destroy {
    my($self,$serverrequest) = @_;
    my $arg_list = [
    ];
    $serverrequest->params($arg_list);
    $self->{impl}->destroy(
    );
}

# IDL:omg.org/CosNaming/NamingContext/list:1.0
sub list {
    my($self,$serverrequest) = @_;
    my $arg_list = [
        { 'argument'  =>
          { _type  => $CORBA::_tc_ulong },
          'arg_modes' => 0,
        },
        { 'argument'  =>
          { _type  => $CosNaming::BindingList::_tc, _value => [] },
          'arg_modes' => 1,
        },
        { 'argument'  =>
          { _type  => $CosNaming::BindingIterator::_tc },
          'arg_modes' => 1,
        },
    ];
    $serverrequest->params($arg_list);
    $self->{impl}->list(
        $arg_list->[0]{argument}{_value},
        $arg_list->[1]{argument}{_value},
        $arg_list->[2]{argument}{_value},
    );
}

# IDL:omg.org/CosNaming/BindingIterator:1.0
package CosNaming::BindingIterator_skel;
push @CosNaming::BindingIterator_impl::ISA, 'CORBA::Object';
@CosNaming::BindingIterator_skel::ISA=qw(CORBA::Object);
$CosNaming::BindingIterator_skel::_id = 0;

sub new {
    my($class,@args) = @_;
    my $impl = CosNaming::BindingIterator_impl->new(@args);
    my $self = bless $CORBA::BOA::_The_Boa->_create('IDL:omg.org/CosNaming/BindingIterator:1.0 ' . $CosNaming::BindingIterator_skel::_id++, 'IDL:omg.org/CosNaming/BindingIterator:1.0', $impl), $class;
    return $impl;
}

# IDL:omg.org/CosNaming/BindingIterator/next_one:1.0
sub next_one {
    my($self,$serverrequest) = @_;
    my $result_ = { _type => $CORBA::_tc_boolean };
    my $arg_list = [
        { 'argument'  =>
          { _type  => $CosNaming::Binding::_tc, _value => {} },
          'arg_modes' => 1,
        },
    ];
    $serverrequest->params($arg_list);
    $serverrequest->result($result_);
    $result_->{_value} = $self->{impl}->next_one(
        $arg_list->[0]{argument}{_value},
    );
}

# IDL:omg.org/CosNaming/BindingIterator/next_n:1.0
sub next_n {
    my($self,$serverrequest) = @_;
    my $result_ = { _type => $CORBA::_tc_boolean };
    my $arg_list = [
        { 'argument'  =>
          { _type  => $CORBA::_tc_ulong },
          'arg_modes' => 0,
        },
        { 'argument'  =>
          { _type  => $CosNaming::BindingList::_tc, _value => [] },
          'arg_modes' => 1,
        },
    ];
    $serverrequest->params($arg_list);
    $serverrequest->result($result_);
    $result_->{_value} = $self->{impl}->next_n(
        $arg_list->[0]{argument}{_value},
        $arg_list->[1]{argument}{_value},
    );
}

# IDL:omg.org/CosNaming/BindingIterator/destroy:1.0
sub destroy {
    my($self,$serverrequest) = @_;
    my $arg_list = [
    ];
    $serverrequest->params($arg_list);
    $self->{impl}->destroy(
    );
}


1;
