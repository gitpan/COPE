# Automatically generated skeleton code, MODIFICATIONS WILL BE LOST.
# Generated on Fri May  9 22:10:10 1997 with the following command:
# ./idl.pl Test.idl

use COPE::Test_types;
use COPE::Test_impl;

# IDL:smop.org/Test/Test2:1.0
package Test::Test2_skel;
push @Test::Test2_impl::ISA, 'CORBA::Object';
@Test::Test2_skel::ISA=qw(CORBA::Object);
$Test::Test2_skel::_id = 0;

sub new {
    my($class,@args) = @_;
    my $impl = Test::Test2_impl->new(@args);
    my $self = bless $CORBA::BOA::_The_Boa->_create('IDL:smop.org/Test/Test2:1.0 ' . $Test::Test2_skel::_id++, 'IDL:smop.org/Test/Test2:1.0', $impl), $class;
    return $impl;
}

# IDL:smop.org/Test/Test2/check:1.0
sub check ($$) {
    my($self,$serverrequest) = @_;
    my $result_ = { _type => CORBA::TypeCode::_create_string_tc(0) };
    my $arg_list = [
    ];
    $serverrequest->params($arg_list);
    $serverrequest->result($result_);
    $result_->{_value} = $self->{impl}->check(
    );
}

# IDL:smop.org/Test/Test2/etest:1.0
sub etest ($$) {
    my($self,$serverrequest) = @_;
    my $arg_list = [
    ];
    $serverrequest->params($arg_list);
    $self->{impl}->etest(
    );
}

# IDL:smop.org/Test/Test2/help_brother:1.0
sub help_brother ($$) {
    my($self,$serverrequest) = @_;
    my $arg_list = [
        { 'argument'  =>
          { _type  => $CORBA::_tc_long },
          'arg_modes' => 2,
        },
        { 'argument'  =>
          { _type  => $Test::Test2::_tc },
          'arg_modes' => 0,
        },
    ];
    $serverrequest->params($arg_list);
    $self->{impl}->help_brother(
        \$arg_list->[0]{argument}{_value},
        $arg_list->[1]{argument}{_value},
    );
}

# IDL:smop.org/Test/Test2/anattr:1.0
sub anattr ($$) {
    my($self,$serverrequest) = @_;
    if ($serverrequest->op_name() eq '_set_anattr') {
        my $arg_list = [
            { 'argument'  =>
              { _type  => CORBA::TypeCode::_create_string_tc(0) },
              'arg_modes' => 0,
            },
        ];
        $serverrequest->params($arg_list);
        $self->{impl}->anattr(
            $arg_list->[0]{argument}{_value}
        );
    } else {
        my $result_ = { _type => CORBA::TypeCode::_create_string_tc(0) };
        $serverrequest->params([]);
        $serverrequest->result($result_);
        $result_->{_value} = $self->{impl}->anattr();
    }
}

# IDL:smop.org/Test/Test2/count:1.0
sub count ($$) {
    my($self,$serverrequest) = @_;
    my $result_ = { _type => $CORBA::_tc_long };
    $serverrequest->params([]);
    $serverrequest->result($result_);
    $result_->{_value} = $self->{impl}->count();
}

# IDL:smop.org/Test/Test1:1.0
package Test::Test1_skel;
push @Test::Test1_impl::ISA, 'CORBA::Object';
@Test::Test1_skel::ISA=qw(CORBA::Object);
$Test::Test1_skel::_id = 0;

sub new {
    my($class,@args) = @_;
    my $impl = Test::Test1_impl->new(@args);
    my $self = bless $CORBA::BOA::_The_Boa->_create('IDL:smop.org/Test/Test1:1.0 ' . $Test::Test1_skel::_id++, 'IDL:smop.org/Test/Test1:1.0', $impl), $class;
    return $impl;
}

# IDL:smop.org/Test/Test1/in_long:1.0
sub in_long ($$) {
    my($self,$serverrequest) = @_;
    my $result_ = { _type => $CORBA::_tc_long };
    my $arg_list = [
        { 'argument'  =>
          { _type  => $CORBA::_tc_long },
          'arg_modes' => 0,
        },
    ];
    $serverrequest->params($arg_list);
    $serverrequest->result($result_);
    $result_->{_value} = $self->{impl}->in_long(
        $arg_list->[0]{argument}{_value},
    );
}

# IDL:smop.org/Test/Test1/in_string:1.0
sub in_string ($$) {
    my($self,$serverrequest) = @_;
    my $result_ = { _type => CORBA::TypeCode::_create_string_tc(0) };
    my $arg_list = [
        { 'argument'  =>
          { _type  => CORBA::TypeCode::_create_string_tc(0) },
          'arg_modes' => 0,
        },
    ];
    $serverrequest->params($arg_list);
    $serverrequest->result($result_);
    $result_->{_value} = $self->{impl}->in_string(
        $arg_list->[0]{argument}{_value},
    );
}

# IDL:smop.org/Test/Test1/in_long_sequence:1.0
sub in_long_sequence ($$) {
    my($self,$serverrequest) = @_;
    my $result_ = { _type => $Test::Test1::LongSeq::_tc };
    my $arg_list = [
        { 'argument'  =>
          { _type  => $Test::Test1::LongSeq::_tc },
          'arg_modes' => 0,
        },
    ];
    $serverrequest->params($arg_list);
    $serverrequest->result($result_);
    $result_->{_value} = $self->{impl}->in_long_sequence(
        $arg_list->[0]{argument}{_value},
    );
}

# IDL:smop.org/Test/Test1/in_octet_sequence:1.0
sub in_octet_sequence ($$) {
    my($self,$serverrequest) = @_;
    my $result_ = { _type => $Test::Test1::OctetSeq::_tc };
    my $arg_list = [
        { 'argument'  =>
          { _type  => $Test::Test1::OctetSeq::_tc },
          'arg_modes' => 0,
        },
    ];
    $serverrequest->params($arg_list);
    $serverrequest->result($result_);
    $result_->{_value} = $self->{impl}->in_octet_sequence(
        $arg_list->[0]{argument}{_value},
    );
}

# IDL:smop.org/Test/Test1/in_struct:1.0
sub in_struct ($$) {
    my($self,$serverrequest) = @_;
    my $result_ = { _type => $Test::TestStruct::_tc };
    my $arg_list = [
        { 'argument'  =>
          { _type  => $Test::TestStruct::_tc },
          'arg_modes' => 0,
        },
    ];
    $serverrequest->params($arg_list);
    $serverrequest->result($result_);
    $result_->{_value} = $self->{impl}->in_struct(
        $arg_list->[0]{argument}{_value},
    );
}

# IDL:smop.org/Test/Test1/in_array:1.0
sub in_array ($$) {
    my($self,$serverrequest) = @_;
    my $result_ = { _type => $Test::Test1::ShortArray::_tc };
    my $arg_list = [
        { 'argument'  =>
          { _type  => $Test::Test1::ShortArray::_tc },
          'arg_modes' => 0,
        },
    ];
    $serverrequest->params($arg_list);
    $serverrequest->result($result_);
    $result_->{_value} = $self->{impl}->in_array(
        $arg_list->[0]{argument}{_value},
    );
}

# IDL:smop.org/Test/Test1/inout_long:1.0
sub inout_long ($$) {
    my($self,$serverrequest) = @_;
    my $arg_list = [
        { 'argument'  =>
          { _type  => $CORBA::_tc_long },
          'arg_modes' => 2,
        },
    ];
    $serverrequest->params($arg_list);
    $self->{impl}->inout_long(
        \$arg_list->[0]{argument}{_value},
    );
}

# IDL:smop.org/Test/Test1/inout_string:1.0
sub inout_string ($$) {
    my($self,$serverrequest) = @_;
    my $arg_list = [
        { 'argument'  =>
          { _type  => CORBA::TypeCode::_create_string_tc(0) },
          'arg_modes' => 2,
        },
    ];
    $serverrequest->params($arg_list);
    $self->{impl}->inout_string(
        \$arg_list->[0]{argument}{_value},
    );
}

# IDL:smop.org/Test/Test1/inout_long_sequence:1.0
sub inout_long_sequence ($$) {
    my($self,$serverrequest) = @_;
    my $arg_list = [
        { 'argument'  =>
          { _type  => $Test::Test1::LongSeq::_tc },
          'arg_modes' => 2,
        },
    ];
    $serverrequest->params($arg_list);
    $self->{impl}->inout_long_sequence(
        $arg_list->[0]{argument}{_value},
    );
}

# IDL:smop.org/Test/Test1/inout_octet_sequence:1.0
sub inout_octet_sequence ($$) {
    my($self,$serverrequest) = @_;
    my $arg_list = [
        { 'argument'  =>
          { _type  => $Test::Test1::OctetSeq::_tc },
          'arg_modes' => 2,
        },
    ];
    $serverrequest->params($arg_list);
    $self->{impl}->inout_octet_sequence(
        \$arg_list->[0]{argument}{_value},
    );
}

# IDL:smop.org/Test/Test1/inout_struct:1.0
sub inout_struct ($$) {
    my($self,$serverrequest) = @_;
    my $arg_list = [
        { 'argument'  =>
          { _type  => $Test::TestStruct::_tc },
          'arg_modes' => 2,
        },
    ];
    $serverrequest->params($arg_list);
    $self->{impl}->inout_struct(
        $arg_list->[0]{argument}{_value},
    );
}

# IDL:smop.org/Test/Test1/inout_array:1.0
sub inout_array ($$) {
    my($self,$serverrequest) = @_;
    my $arg_list = [
        { 'argument'  =>
          { _type  => $Test::Test1::ShortArray::_tc },
          'arg_modes' => 2,
        },
    ];
    $serverrequest->params($arg_list);
    $self->{impl}->inout_array(
        $arg_list->[0]{argument}{_value},
    );
}

# IDL:smop.org/Test/Test1/out_long:1.0
sub out_long ($$) {
    my($self,$serverrequest) = @_;
    my $arg_list = [
        { 'argument'  =>
          { _type  => $CORBA::_tc_long },
          'arg_modes' => 1,
        },
    ];
    $serverrequest->params($arg_list);
    $self->{impl}->out_long(
        \$arg_list->[0]{argument}{_value},
    );
}

# IDL:smop.org/Test/Test1/out_string:1.0
sub out_string ($$) {
    my($self,$serverrequest) = @_;
    my $arg_list = [
        { 'argument'  =>
          { _type  => CORBA::TypeCode::_create_string_tc(0) },
          'arg_modes' => 1,
        },
    ];
    $serverrequest->params($arg_list);
    $self->{impl}->out_string(
        \$arg_list->[0]{argument}{_value},
    );
}

# IDL:smop.org/Test/Test1/out_long_sequence:1.0
sub out_long_sequence ($$) {
    my($self,$serverrequest) = @_;
    my $arg_list = [
        { 'argument'  =>
          { _type  => $Test::Test1::LongSeq::_tc, _value => [] },
          'arg_modes' => 1,
        },
    ];
    $serverrequest->params($arg_list);
    $self->{impl}->out_long_sequence(
        $arg_list->[0]{argument}{_value},
    );
}

# IDL:smop.org/Test/Test1/out_octet_sequence:1.0
sub out_octet_sequence ($$) {
    my($self,$serverrequest) = @_;
    my $arg_list = [
        { 'argument'  =>
          { _type  => $Test::Test1::OctetSeq::_tc },
          'arg_modes' => 1,
        },
    ];
    $serverrequest->params($arg_list);
    $self->{impl}->out_octet_sequence(
        \$arg_list->[0]{argument}{_value},
    );
}

# IDL:smop.org/Test/Test1/out_struct:1.0
sub out_struct ($$) {
    my($self,$serverrequest) = @_;
    my $arg_list = [
        { 'argument'  =>
          { _type  => $Test::TestStruct::_tc, _value => {} },
          'arg_modes' => 1,
        },
    ];
    $serverrequest->params($arg_list);
    $self->{impl}->out_struct(
        $arg_list->[0]{argument}{_value},
    );
}

# IDL:smop.org/Test/Test1/out_array:1.0
sub out_array ($$) {
    my($self,$serverrequest) = @_;
    my $arg_list = [
        { 'argument'  =>
          { _type  => $Test::Test1::ShortArray::_tc, _value => [] },
          'arg_modes' => 1,
        },
    ];
    $serverrequest->params($arg_list);
    $self->{impl}->out_array(
        $arg_list->[0]{argument}{_value},
    );
}

# IDL:smop.org/Test/Test1/ret_object:1.0
sub ret_object ($$) {
    my($self,$serverrequest) = @_;
    my $result_ = { _type => $Test::Test2::_tc };
    my $arg_list = [
    ];
    $serverrequest->params($arg_list);
    $serverrequest->result($result_);
    $result_->{_value} = $self->{impl}->ret_object(
    );
}


1;
