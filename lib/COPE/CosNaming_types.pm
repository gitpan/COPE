# Automatically generated type code, DO NOT EDIT.
# Generated on Thu Jun  5 21:37:55 1997 with the following command:
# /opt/perl/bin/idl2perl --impl Naming.idl

use COPE::CORBA::TypeCode;
use COPE::CORBA::Object;

# IDL:omg.org/CosNaming:1.0
# IDL:omg.org/CosNaming/Istring:1.0
package CosNaming::Istring;
$CosNaming::Istring::_tc = CORBA::TypeCode::_create_string_tc(0);

# IDL:omg.org/CosNaming/NameComponent:1.0
package CosNaming::NameComponent;
@CosNaming::NameComponent::ISA=qw(CORBA::_Struct);
$CosNaming::NameComponent::_tc = CORBA::TypeCode::_create_struct_tc('IDL:omg.org/CosNaming/NameComponent:1.0', 'NameComponent', ['id' => $CosNaming::Istring::_tc, 'kind' => $CosNaming::Istring::_tc]);

# IDL:omg.org/CosNaming/Name:1.0
package CosNaming::Name;
$CosNaming::Name::_tc = CORBA::TypeCode::_create_sequence_tc(0, $CosNaming::NameComponent::_tc);

# IDL:omg.org/CosNaming/BindingType:1.0
package CosNaming::BindingType;
$CosNaming::BindingType::_tc = CORBA::TypeCode::_create_enum_tc('IDL:omg.org/CosNaming/BindingType:1.0', 'BindingType', ['nobject', 'ncontext']);
sub nobject () {0}
sub ncontext () {1}

# IDL:omg.org/CosNaming/Binding:1.0
package CosNaming::Binding;
@CosNaming::Binding::ISA=qw(CORBA::_Struct);
$CosNaming::Binding::_tc = CORBA::TypeCode::_create_struct_tc('IDL:omg.org/CosNaming/Binding:1.0', 'Binding', ['binding_name' => $CosNaming::Name::_tc, 'binding_type' => $CosNaming::BindingType::_tc]);

# IDL:omg.org/CosNaming/BindingList:1.0
package CosNaming::BindingList;
$CosNaming::BindingList::_tc = CORBA::TypeCode::_create_sequence_tc(0, $CosNaming::Binding::_tc);

# IDL:omg.org/CosNaming/NamingContext:1.0
package CosNaming::NamingContext;
$CosNaming::NamingContext::_tc = CORBA::TypeCode::_create_interface_tc('IDL:omg.org/CosNaming/NamingContext:1.0', 'NamingContext');

# IDL:omg.org/CosNaming/NamingContext/NotFoundReason:1.0
package CosNaming::NamingContext::NotFoundReason;
$CosNaming::NamingContext::NotFoundReason::_tc = CORBA::TypeCode::_create_enum_tc('IDL:omg.org/CosNaming/NamingContext/NotFoundReason:1.0', 'NotFoundReason', ['missing_node', 'not_context', 'not_object']);
sub missing_node () {0}
sub not_context () {1}
sub not_object () {2}

# IDL:omg.org/CosNaming/NamingContext/NotFound:1.0
package CosNaming::NamingContext::NotFound;
@CosNaming::NamingContext::NotFound::ISA=qw(Experimental::Exception);
$CosNaming::NamingContext::NotFound::_tc = CORBA::TypeCode::_create_exception_tc('IDL:omg.org/CosNaming/NamingContext/NotFound:1.0', 'NotFound', ['why' => $CosNaming::NamingContext::NotFoundReason::_tc, 'rest_of_name' => $CosNaming::Name::_tc]);

# IDL:omg.org/CosNaming/NamingContext/CannotProceed:1.0
package CosNaming::NamingContext::CannotProceed;
@CosNaming::NamingContext::CannotProceed::ISA=qw(Experimental::Exception);
$CosNaming::NamingContext::CannotProceed::_tc = CORBA::TypeCode::_create_exception_tc('IDL:omg.org/CosNaming/NamingContext/CannotProceed:1.0', 'CannotProceed', ['cxt' => $CosNaming::NamingContext::_tc, 'rest_of_name' => $CosNaming::Name::_tc]);

# IDL:omg.org/CosNaming/NamingContext/InvalidName:1.0
package CosNaming::NamingContext::InvalidName;
@CosNaming::NamingContext::InvalidName::ISA=qw(Experimental::Exception);
$CosNaming::NamingContext::InvalidName::_tc = CORBA::TypeCode::_create_exception_tc('IDL:omg.org/CosNaming/NamingContext/InvalidName:1.0', 'InvalidName', []);

# IDL:omg.org/CosNaming/NamingContext/AlreadyBound:1.0
package CosNaming::NamingContext::AlreadyBound;
@CosNaming::NamingContext::AlreadyBound::ISA=qw(Experimental::Exception);
$CosNaming::NamingContext::AlreadyBound::_tc = CORBA::TypeCode::_create_exception_tc('IDL:omg.org/CosNaming/NamingContext/AlreadyBound:1.0', 'AlreadyBound', []);

# IDL:omg.org/CosNaming/NamingContext/NotEmpty:1.0
package CosNaming::NamingContext::NotEmpty;
@CosNaming::NamingContext::NotEmpty::ISA=qw(Experimental::Exception);
$CosNaming::NamingContext::NotEmpty::_tc = CORBA::TypeCode::_create_exception_tc('IDL:omg.org/CosNaming/NamingContext/NotEmpty:1.0', 'NotEmpty', []);

# IDL:omg.org/CosNaming/BindingIterator:1.0
package CosNaming::BindingIterator;
$CosNaming::BindingIterator::_tc = CORBA::TypeCode::_create_interface_tc('IDL:omg.org/CosNaming/BindingIterator:1.0', 'BindingIterator');



1;
