# Automatically generated type code, DO NOT EDIT.
# Generated on Fri May  9 22:10:10 1997 with the following command:
# ./idl.pl Test.idl

use COPE::CORBA::TypeCode;
use COPE::CORBA::Object;

# IDL:smop.org/Test:1.0
# IDL:smop.org/Test/TestStruct:1.0
package Test::TestStruct;
@Test::TestStruct::ISA=qw(CORBA::_Struct);
$Test::TestStruct::_tc = CORBA::TypeCode::_create_struct_tc('IDL:smop.org/Test/TestStruct:1.0', 'TestStruct', ['astring' => CORBA::TypeCode::_create_string_tc(0), 'ashort' => $CORBA::_tc_short]);

# IDL:smop.org/Test/Test2:1.0
package Test::Test2;
$Test::Test2::_tc = CORBA::TypeCode::_create_interface_tc('IDL:smop.org/Test/Test2:1.0', 'Test2');

# IDL:smop.org/Test/Test2/AnException:1.0
package Test::Test2::AnException;
@Test::Test2::AnException::ISA=qw(CORBA::UserException);
$Test::Test2::AnException::_tc = CORBA::TypeCode::_create_exception_tc('IDL:smop.org/Test/Test2/AnException:1.0', 'AnException', ['why' => CORBA::TypeCode::_create_string_tc(0), 'minor' => $CORBA::_tc_short]);

# IDL:smop.org/Test/Test2/NAME:1.0
package Test::Test2;
$Test::Test2::NAME = 'Bart';
# IDL:smop.org/Test/Test2/AGE:1.0
$Test::Test2::AGE = 28;
# IDL:smop.org/Test/Test1:1.0
package Test::Test1;
$Test::Test1::_tc = CORBA::TypeCode::_create_interface_tc('IDL:smop.org/Test/Test1:1.0', 'Test1');

# IDL:smop.org/Test/Test1/LongSeq:1.0
package Test::Test1::LongSeq;
$Test::Test1::LongSeq::_tc = CORBA::TypeCode::_create_sequence_tc(0, $CORBA::_tc_long);

# IDL:smop.org/Test/Test1/OctetSeq:1.0
package Test::Test1::OctetSeq;
$Test::Test1::OctetSeq::_tc = CORBA::TypeCode::_create_sequence_tc(0, $CORBA::_tc_octet);

# IDL:smop.org/Test/Test1/ShortArray:1.0
package Test::Test1::ShortArray;
$Test::Test1::ShortArray::_tc = CORBA::TypeCode::_create_array_tc(4, $CORBA::_tc_short);



1;
