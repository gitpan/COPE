# Automatically generated stub code, DO NOT EDIT.
# Generated on Fri May  9 22:10:10 1997 with the following command:
# ./idl.pl Test.idl

use COPE::Test_types;

# IDL:smop.org/Test/Test2:1.0
package Test::Test2;
@Test::Test2::ISA=qw(CORBA::Object);
# IDL:smop.org/Test/Test2/check:1.0
sub check ($) {
    my($self) = @_;
    my $result_ = { _type => CORBA::TypeCode::_create_string_tc(0) };
    my $request_ = $self->create_request(
        'operation' => 'check',
        'arg_list'  => [
                       ],
        'result'    => $result_,
    );
    $request_->invoke(0);
    return $result_->{_value};
}

# IDL:smop.org/Test/Test2/etest:1.0
sub etest ($) {
    my($self) = @_;
    my $result_ = { _type => $CORBA::_tc_void };
    my $request_ = $self->create_request(
        'operation' => 'etest',
        'arg_list'  => [
                       ],
        'result'    => $result_,
    );
    $request_->invoke(0);
}

# IDL:smop.org/Test/Test2/help_brother:1.0
sub help_brother ($$$) {
    my($self,$counter,$my_brother) = @_;
    my $result_ = { _type => $CORBA::_tc_void };
    my $request_ = $self->create_request(
        'operation' => 'help_brother',
        'arg_list'  => [
        { 'argument'  =>
          { _type  => $CORBA::_tc_long, _value => $counter },
          'arg_modes' => 2,
        },
        { 'argument'  =>
          { _type  => $Test::Test2::_tc, _value => $my_brother },
          'arg_modes' => 0,
        },
                       ],
        'result'    => $result_,
    );
    $request_->invoke(0);
}

# IDL:smop.org/Test/Test2/anattr:1.0
sub anattr ($;$) {
    my($self,@rest) = @_;
    return $self->_attribute('anattr', CORBA::TypeCode::_create_string_tc(0), @rest);
}

# IDL:smop.org/Test/Test2/count:1.0
sub count ($) {
    my($self,@rest) = @_;
    return $self->_attribute('count', $CORBA::_tc_long, @rest);
}

# IDL:smop.org/Test/Test1:1.0
package Test::Test1;
@Test::Test1::ISA=qw(CORBA::Object);
# IDL:smop.org/Test/Test1/in_long:1.0
sub in_long ($$) {
    my($self,$along) = @_;
    my $result_ = { _type => $CORBA::_tc_long };
    my $request_ = $self->create_request(
        'operation' => 'in_long',
        'arg_list'  => [
        { 'argument'  =>
          { _type  => $CORBA::_tc_long, _value => $along },
          'arg_modes' => 0,
        },
                       ],
        'result'    => $result_,
    );
    $request_->invoke(0);
    return $result_->{_value};
}

# IDL:smop.org/Test/Test1/in_string:1.0
sub in_string ($$) {
    my($self,$astring) = @_;
    my $result_ = { _type => CORBA::TypeCode::_create_string_tc(0) };
    my $request_ = $self->create_request(
        'operation' => 'in_string',
        'arg_list'  => [
        { 'argument'  =>
          { _type  => CORBA::TypeCode::_create_string_tc(0), _value => $astring },
          'arg_modes' => 0,
        },
                       ],
        'result'    => $result_,
    );
    $request_->invoke(0);
    return $result_->{_value};
}

# IDL:smop.org/Test/Test1/in_long_sequence:1.0
sub in_long_sequence ($$) {
    my($self,$asequence) = @_;
    my $result_ = { _type => $Test::Test1::LongSeq::_tc };
    my $request_ = $self->create_request(
        'operation' => 'in_long_sequence',
        'arg_list'  => [
        { 'argument'  =>
          { _type  => $Test::Test1::LongSeq::_tc, _value => $asequence },
          'arg_modes' => 0,
        },
                       ],
        'result'    => $result_,
    );
    $request_->invoke(0);
    return $result_->{_value};
}

# IDL:smop.org/Test/Test1/in_octet_sequence:1.0
sub in_octet_sequence ($$) {
    my($self,$asequence) = @_;
    my $result_ = { _type => $Test::Test1::OctetSeq::_tc };
    my $request_ = $self->create_request(
        'operation' => 'in_octet_sequence',
        'arg_list'  => [
        { 'argument'  =>
          { _type  => $Test::Test1::OctetSeq::_tc, _value => $asequence },
          'arg_modes' => 0,
        },
                       ],
        'result'    => $result_,
    );
    $request_->invoke(0);
    return $result_->{_value};
}

# IDL:smop.org/Test/Test1/in_struct:1.0
sub in_struct ($$) {
    my($self,$astruct) = @_;
    my $result_ = { _type => $Test::TestStruct::_tc };
    my $request_ = $self->create_request(
        'operation' => 'in_struct',
        'arg_list'  => [
        { 'argument'  =>
          { _type  => $Test::TestStruct::_tc, _value => $astruct },
          'arg_modes' => 0,
        },
                       ],
        'result'    => $result_,
    );
    $request_->invoke(0);
    return $result_->{_value};
}

# IDL:smop.org/Test/Test1/in_array:1.0
sub in_array ($$) {
    my($self,$anarray) = @_;
    my $result_ = { _type => $Test::Test1::ShortArray::_tc };
    my $request_ = $self->create_request(
        'operation' => 'in_array',
        'arg_list'  => [
        { 'argument'  =>
          { _type  => $Test::Test1::ShortArray::_tc, _value => $anarray },
          'arg_modes' => 0,
        },
                       ],
        'result'    => $result_,
    );
    $request_->invoke(0);
    return $result_->{_value};
}

# IDL:smop.org/Test/Test1/inout_long:1.0
sub inout_long ($$) {
    my($self,$along) = @_;
    my $result_ = { _type => $CORBA::_tc_void };
    my $request_ = $self->create_request(
        'operation' => 'inout_long',
        'arg_list'  => [
        { 'argument'  =>
          { _type  => $CORBA::_tc_long, _value => $along },
          'arg_modes' => 2,
        },
                       ],
        'result'    => $result_,
    );
    $request_->invoke(0);
}

# IDL:smop.org/Test/Test1/inout_string:1.0
sub inout_string ($$) {
    my($self,$astring) = @_;
    my $result_ = { _type => $CORBA::_tc_void };
    my $request_ = $self->create_request(
        'operation' => 'inout_string',
        'arg_list'  => [
        { 'argument'  =>
          { _type  => CORBA::TypeCode::_create_string_tc(0), _value => $astring },
          'arg_modes' => 2,
        },
                       ],
        'result'    => $result_,
    );
    $request_->invoke(0);
}

# IDL:smop.org/Test/Test1/inout_long_sequence:1.0
sub inout_long_sequence ($$) {
    my($self,$asequence) = @_;
    my $result_ = { _type => $CORBA::_tc_void };
    my $request_ = $self->create_request(
        'operation' => 'inout_long_sequence',
        'arg_list'  => [
        { 'argument'  =>
          { _type  => $Test::Test1::LongSeq::_tc, _value => $asequence },
          'arg_modes' => 2,
        },
                       ],
        'result'    => $result_,
    );
    $request_->invoke(0);
}

# IDL:smop.org/Test/Test1/inout_octet_sequence:1.0
sub inout_octet_sequence ($$) {
    my($self,$asequence) = @_;
    my $result_ = { _type => $CORBA::_tc_void };
    my $request_ = $self->create_request(
        'operation' => 'inout_octet_sequence',
        'arg_list'  => [
        { 'argument'  =>
          { _type  => $Test::Test1::OctetSeq::_tc, _value => $asequence },
          'arg_modes' => 2,
        },
                       ],
        'result'    => $result_,
    );
    $request_->invoke(0);
}

# IDL:smop.org/Test/Test1/inout_struct:1.0
sub inout_struct ($$) {
    my($self,$astruct) = @_;
    my $result_ = { _type => $CORBA::_tc_void };
    my $request_ = $self->create_request(
        'operation' => 'inout_struct',
        'arg_list'  => [
        { 'argument'  =>
          { _type  => $Test::TestStruct::_tc, _value => $astruct },
          'arg_modes' => 2,
        },
                       ],
        'result'    => $result_,
    );
    $request_->invoke(0);
}

# IDL:smop.org/Test/Test1/inout_array:1.0
sub inout_array ($$) {
    my($self,$anarray) = @_;
    my $result_ = { _type => $CORBA::_tc_void };
    my $request_ = $self->create_request(
        'operation' => 'inout_array',
        'arg_list'  => [
        { 'argument'  =>
          { _type  => $Test::Test1::ShortArray::_tc, _value => $anarray },
          'arg_modes' => 2,
        },
                       ],
        'result'    => $result_,
    );
    $request_->invoke(0);
}

# IDL:smop.org/Test/Test1/out_long:1.0
sub out_long ($$) {
    my($self,$along) = @_;
    my $result_ = { _type => $CORBA::_tc_void };
    my $request_ = $self->create_request(
        'operation' => 'out_long',
        'arg_list'  => [
        { 'argument'  =>
          { _type  => $CORBA::_tc_long, _value => $along },
          'arg_modes' => 1,
        },
                       ],
        'result'    => $result_,
    );
    $request_->invoke(0);
}

# IDL:smop.org/Test/Test1/out_string:1.0
sub out_string ($$) {
    my($self,$astring) = @_;
    my $result_ = { _type => $CORBA::_tc_void };
    my $request_ = $self->create_request(
        'operation' => 'out_string',
        'arg_list'  => [
        { 'argument'  =>
          { _type  => CORBA::TypeCode::_create_string_tc(0), _value => $astring },
          'arg_modes' => 1,
        },
                       ],
        'result'    => $result_,
    );
    $request_->invoke(0);
}

# IDL:smop.org/Test/Test1/out_long_sequence:1.0
sub out_long_sequence ($$) {
    my($self,$asequence) = @_;
    my $result_ = { _type => $CORBA::_tc_void };
    my $request_ = $self->create_request(
        'operation' => 'out_long_sequence',
        'arg_list'  => [
        { 'argument'  =>
          { _type  => $Test::Test1::LongSeq::_tc, _value => $asequence },
          'arg_modes' => 1,
        },
                       ],
        'result'    => $result_,
    );
    $request_->invoke(0);
}

# IDL:smop.org/Test/Test1/out_octet_sequence:1.0
sub out_octet_sequence ($$) {
    my($self,$asequence) = @_;
    my $result_ = { _type => $CORBA::_tc_void };
    my $request_ = $self->create_request(
        'operation' => 'out_octet_sequence',
        'arg_list'  => [
        { 'argument'  =>
          { _type  => $Test::Test1::OctetSeq::_tc, _value => $asequence },
          'arg_modes' => 1,
        },
                       ],
        'result'    => $result_,
    );
    $request_->invoke(0);
}

# IDL:smop.org/Test/Test1/out_struct:1.0
sub out_struct ($$) {
    my($self,$astruct) = @_;
    my $result_ = { _type => $CORBA::_tc_void };
    my $request_ = $self->create_request(
        'operation' => 'out_struct',
        'arg_list'  => [
        { 'argument'  =>
          { _type  => $Test::TestStruct::_tc, _value => $astruct },
          'arg_modes' => 1,
        },
                       ],
        'result'    => $result_,
    );
    $request_->invoke(0);
}

# IDL:smop.org/Test/Test1/out_array:1.0
sub out_array ($$) {
    my($self,$anarray) = @_;
    my $result_ = { _type => $CORBA::_tc_void };
    my $request_ = $self->create_request(
        'operation' => 'out_array',
        'arg_list'  => [
        { 'argument'  =>
          { _type  => $Test::Test1::ShortArray::_tc, _value => $anarray },
          'arg_modes' => 1,
        },
                       ],
        'result'    => $result_,
    );
    $request_->invoke(0);
}

# IDL:smop.org/Test/Test1/ret_object:1.0
sub ret_object ($) {
    my($self) = @_;
    my $result_ = { _type => $Test::Test2::_tc };
    my $request_ = $self->create_request(
        'operation' => 'ret_object',
        'arg_list'  => [
                       ],
        'result'    => $result_,
    );
    $request_->invoke(0);
    return $result_->{_value};
}


1;
