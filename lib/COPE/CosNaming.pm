# Automatically generated stub code, DO NOT EDIT.
# Generated on Thu Jun  5 21:37:55 1997 with the following command:
# /opt/perl/bin/idl2perl --impl Naming.idl

use COPE::CosNaming_types;

# IDL:omg.org/CosNaming/NamingContext:1.0
package CosNaming::NamingContext;
@CosNaming::NamingContext::ISA=qw(CORBA::Object);
# IDL:omg.org/CosNaming/NamingContext/bind:1.0
sub bind {
    my($self,$n,$obj) = @_;
    my $result_ = { _type => $CORBA::_tc_void };
    my $request_ = $self->create_request(
        'operation' => 'bind',
        'arg_list'  => [
        { 'argument'  =>
          { _type  => $CosNaming::Name::_tc, _value => $n },
          'arg_modes' => 0,
        },
        { 'argument'  =>
          { _type  => $CORBA::Object::_tc, _value => $obj },
          'arg_modes' => 0,
        },
                       ],
        'result'    => $result_,
    );
    $request_->invoke(0);
}

# IDL:omg.org/CosNaming/NamingContext/rebind:1.0
sub rebind {
    my($self,$n,$obj) = @_;
    my $result_ = { _type => $CORBA::_tc_void };
    my $request_ = $self->create_request(
        'operation' => 'rebind',
        'arg_list'  => [
        { 'argument'  =>
          { _type  => $CosNaming::Name::_tc, _value => $n },
          'arg_modes' => 0,
        },
        { 'argument'  =>
          { _type  => $CORBA::Object::_tc, _value => $obj },
          'arg_modes' => 0,
        },
                       ],
        'result'    => $result_,
    );
    $request_->invoke(0);
}

# IDL:omg.org/CosNaming/NamingContext/bind_context:1.0
sub bind_context {
    my($self,$n,$nc) = @_;
    my $result_ = { _type => $CORBA::_tc_void };
    my $request_ = $self->create_request(
        'operation' => 'bind_context',
        'arg_list'  => [
        { 'argument'  =>
          { _type  => $CosNaming::Name::_tc, _value => $n },
          'arg_modes' => 0,
        },
        { 'argument'  =>
          { _type  => $CosNaming::NamingContext::_tc, _value => $nc },
          'arg_modes' => 0,
        },
                       ],
        'result'    => $result_,
    );
    $request_->invoke(0);
}

# IDL:omg.org/CosNaming/NamingContext/rebind_context:1.0
sub rebind_context {
    my($self,$n,$nc) = @_;
    my $result_ = { _type => $CORBA::_tc_void };
    my $request_ = $self->create_request(
        'operation' => 'rebind_context',
        'arg_list'  => [
        { 'argument'  =>
          { _type  => $CosNaming::Name::_tc, _value => $n },
          'arg_modes' => 0,
        },
        { 'argument'  =>
          { _type  => $CosNaming::NamingContext::_tc, _value => $nc },
          'arg_modes' => 0,
        },
                       ],
        'result'    => $result_,
    );
    $request_->invoke(0);
}

# IDL:omg.org/CosNaming/NamingContext/resolve:1.0
sub resolve {
    my($self,$n) = @_;
    my $result_ = { _type => $CORBA::Object::_tc };
    my $request_ = $self->create_request(
        'operation' => 'resolve',
        'arg_list'  => [
        { 'argument'  =>
          { _type  => $CosNaming::Name::_tc, _value => $n },
          'arg_modes' => 0,
        },
                       ],
        'result'    => $result_,
    );
    $request_->invoke(0);
    return $result_->{_value};
}

# IDL:omg.org/CosNaming/NamingContext/unbind:1.0
sub unbind {
    my($self,$n) = @_;
    my $result_ = { _type => $CORBA::_tc_void };
    my $request_ = $self->create_request(
        'operation' => 'unbind',
        'arg_list'  => [
        { 'argument'  =>
          { _type  => $CosNaming::Name::_tc, _value => $n },
          'arg_modes' => 0,
        },
                       ],
        'result'    => $result_,
    );
    $request_->invoke(0);
}

# IDL:omg.org/CosNaming/NamingContext/new_context:1.0
sub new_context {
    my($self) = @_;
    my $result_ = { _type => $CosNaming::NamingContext::_tc };
    my $request_ = $self->create_request(
        'operation' => 'new_context',
        'arg_list'  => [
                       ],
        'result'    => $result_,
    );
    $request_->invoke(0);
    return $result_->{_value};
}

# IDL:omg.org/CosNaming/NamingContext/bind_new_context:1.0
sub bind_new_context {
    my($self,$n) = @_;
    my $result_ = { _type => $CosNaming::NamingContext::_tc };
    my $request_ = $self->create_request(
        'operation' => 'bind_new_context',
        'arg_list'  => [
        { 'argument'  =>
          { _type  => $CosNaming::Name::_tc, _value => $n },
          'arg_modes' => 0,
        },
                       ],
        'result'    => $result_,
    );
    $request_->invoke(0);
    return $result_->{_value};
}

# IDL:omg.org/CosNaming/NamingContext/destroy:1.0
sub destroy {
    my($self) = @_;
    my $result_ = { _type => $CORBA::_tc_void };
    my $request_ = $self->create_request(
        'operation' => 'destroy',
        'arg_list'  => [
                       ],
        'result'    => $result_,
    );
    $request_->invoke(0);
}

# IDL:omg.org/CosNaming/NamingContext/list:1.0
sub list {
    my($self,$how_many,$bl,$bi) = @_;
    my $result_ = { _type => $CORBA::_tc_void };
    my $request_ = $self->create_request(
        'operation' => 'list',
        'arg_list'  => [
        { 'argument'  =>
          { _type  => $CORBA::_tc_ulong, _value => $how_many },
          'arg_modes' => 0,
        },
        { 'argument'  =>
          { _type  => $CosNaming::BindingList::_tc, _value => $bl },
          'arg_modes' => 1,
        },
        { 'argument'  =>
          { _type  => $CosNaming::BindingIterator::_tc, _value => $bi },
          'arg_modes' => 1,
        },
                       ],
        'result'    => $result_,
    );
    $request_->invoke(0);
}

# IDL:omg.org/CosNaming/BindingIterator:1.0
package CosNaming::BindingIterator;
@CosNaming::BindingIterator::ISA=qw(CORBA::Object);
# IDL:omg.org/CosNaming/BindingIterator/next_one:1.0
sub next_one {
    my($self,$b) = @_;
    my $result_ = { _type => $CORBA::_tc_boolean };
    my $request_ = $self->create_request(
        'operation' => 'next_one',
        'arg_list'  => [
        { 'argument'  =>
          { _type  => $CosNaming::Binding::_tc, _value => $b },
          'arg_modes' => 1,
        },
                       ],
        'result'    => $result_,
    );
    $request_->invoke(0);
    return $result_->{_value};
}

# IDL:omg.org/CosNaming/BindingIterator/next_n:1.0
sub next_n {
    my($self,$how_many,$bl) = @_;
    my $result_ = { _type => $CORBA::_tc_boolean };
    my $request_ = $self->create_request(
        'operation' => 'next_n',
        'arg_list'  => [
        { 'argument'  =>
          { _type  => $CORBA::_tc_ulong, _value => $how_many },
          'arg_modes' => 0,
        },
        { 'argument'  =>
          { _type  => $CosNaming::BindingList::_tc, _value => $bl },
          'arg_modes' => 1,
        },
                       ],
        'result'    => $result_,
    );
    $request_->invoke(0);
    return $result_->{_value};
}

# IDL:omg.org/CosNaming/BindingIterator/destroy:1.0
sub destroy {
    my($self) = @_;
    my $result_ = { _type => $CORBA::_tc_void };
    my $request_ = $self->create_request(
        'operation' => 'destroy',
        'arg_list'  => [
                       ],
        'result'    => $result_,
    );
    $request_->invoke(0);
}


1;
