# $Id: IR_types.pm,v 1.2 1997/05/23 12:34:43 schuller Exp $
# Copyright (c) 1997 Lunatech Research / Bart Schuller <schuller@lunatech.com>
# See the file "Artistic" in the distribution for licensing and
# (lack of) warranties.

# Automatically generated type code, DO NOT EDIT.
# Generated on Wed May 21 15:37:03 1997 with the following command:
# ./bin/idl2perl IR.idl

use COPE::CORBA::TypeCode;
use COPE::CORBA::Object;

# IDL:omg.org/CORBA:1.0
# IDL:omg.org/CORBA/Identifier:1.0
package CORBA::Identifier;
$CORBA::Identifier::_tc = CORBA::TypeCode::_create_string_tc(0);

# IDL:omg.org/CORBA/ScopedName:1.0
package CORBA::ScopedName;
$CORBA::ScopedName::_tc = CORBA::TypeCode::_create_string_tc(0);

# IDL:omg.org/CORBA/RepositoryId:1.0
package CORBA::RepositoryId;
$CORBA::RepositoryId::_tc = CORBA::TypeCode::_create_string_tc(0);

# IDL:omg.org/CORBA/DefinitionKind:1.0
package CORBA::DefinitionKind;
$CORBA::DefinitionKind::_tc = CORBA::TypeCode::_create_enum_tc('IDL:omg.org/CORBA/DefinitionKind:1.0', 'DefinitionKind', ['dk_none', 'dk_all', 'dk_Attribute', 'dk_Constant', 'dk_Exception', 'dk_Interface', 'dk_Module', 'dk_Operation', 'dk_Typedef', 'dk_Alias', 'dk_Struct', 'dk_Union', 'dk_Enum', 'dk_Primitive', 'dk_String', 'dk_Sequence', 'dk_Array', 'dk_Repository']);
sub dk_none () {0}
sub dk_all () {1}
sub dk_Attribute () {2}
sub dk_Constant () {3}
sub dk_Exception () {4}
sub dk_Interface () {5}
sub dk_Module () {6}
sub dk_Operation () {7}
sub dk_Typedef () {8}
sub dk_Alias () {9}
sub dk_Struct () {10}
sub dk_Union () {11}
sub dk_Enum () {12}
sub dk_Primitive () {13}
sub dk_String () {14}
sub dk_Sequence () {15}
sub dk_Array () {16}
sub dk_Repository () {17}

# IDL:omg.org/CORBA/IRObject:1.0
package CORBA::IRObject;
$CORBA::IRObject::_tc = CORBA::TypeCode::_create_interface_tc('IDL:omg.org/CORBA/IRObject:1.0', 'IRObject');

# IDL:omg.org/CORBA/Principal:1.0
package CORBA::Principal;
$CORBA::Principal::_tc = CORBA::TypeCode::_create_interface_tc('IDL:omg.org/CORBA/Principal:1.0', 'Principal');

# IDL:omg.org/CORBA/VersionSpec:1.0
package CORBA::VersionSpec;
$CORBA::VersionSpec::_tc = CORBA::TypeCode::_create_string_tc(0);

# IDL:omg.org/CORBA/Contained:1.0
package CORBA::Contained;
$CORBA::Contained::_tc = CORBA::TypeCode::_create_interface_tc('IDL:omg.org/CORBA/Contained:1.0', 'Contained');

# IDL:omg.org/CORBA/Contained/Description:1.0
package CORBA::Contained::Description;
@CORBA::Contained::Description::ISA=qw(CORBA::_Struct);
$CORBA::Contained::Description::_tc = CORBA::TypeCode::_create_struct_tc('IDL:omg.org/CORBA/Contained/Description:1.0', 'Description', ['kind' => $CORBA::DefinitionKind::_tc, 'value' => $CORBA::_tc_any]);

# IDL:omg.org/CORBA/InterfaceDef:1.0
package CORBA::InterfaceDef;
$CORBA::InterfaceDef::_tc = CORBA::TypeCode::_create_interface_tc('IDL:omg.org/CORBA/InterfaceDef:1.0', 'InterfaceDef');

# IDL:omg.org/CORBA/InterfaceDefSeq:1.0
package CORBA::InterfaceDefSeq;
$CORBA::InterfaceDefSeq::_tc = CORBA::TypeCode::_create_sequence_tc(0, $CORBA::InterfaceDef::_tc);

# IDL:omg.org/CORBA/ContainedSeq:1.0
package CORBA::ContainedSeq;
$CORBA::ContainedSeq::_tc = CORBA::TypeCode::_create_sequence_tc(0, $CORBA::Contained::_tc);

# IDL:omg.org/CORBA/StructMember:1.0
package CORBA::StructMember;
@CORBA::StructMember::ISA=qw(CORBA::_Struct);
$CORBA::StructMember::_tc = CORBA::TypeCode::_create_struct_tc('IDL:omg.org/CORBA/StructMember:1.0', 'StructMember', ['name' => $CORBA::Identifier::_tc, 'type' => $CORBA::_tc_TypeCode, 'type_def' => $CORBA::IDLType::_tc]);

# IDL:omg.org/CORBA/StructMemberSeq:1.0
package CORBA::StructMemberSeq;
$CORBA::StructMemberSeq::_tc = CORBA::TypeCode::_create_sequence_tc(0, $CORBA::StructMember::_tc);

# IDL:omg.org/CORBA/UnionMember:1.0
package CORBA::UnionMember;
@CORBA::UnionMember::ISA=qw(CORBA::_Struct);
$CORBA::UnionMember::_tc = CORBA::TypeCode::_create_struct_tc('IDL:omg.org/CORBA/UnionMember:1.0', 'UnionMember', ['name' => $CORBA::Identifier::_tc, 'label' => $CORBA::_tc_any, 'type' => $CORBA::_tc_TypeCode, 'type_def' => $CORBA::IDLType::_tc]);

# IDL:omg.org/CORBA/UnionMemberSeq:1.0
package CORBA::UnionMemberSeq;
$CORBA::UnionMemberSeq::_tc = CORBA::TypeCode::_create_sequence_tc(0, $CORBA::UnionMember::_tc);

# IDL:omg.org/CORBA/EnumMemberSeq:1.0
package CORBA::EnumMemberSeq;
$CORBA::EnumMemberSeq::_tc = CORBA::TypeCode::_create_sequence_tc(0, $CORBA::Identifier::_tc);

# IDL:omg.org/CORBA/Container:1.0
package CORBA::Container;
$CORBA::Container::_tc = CORBA::TypeCode::_create_interface_tc('IDL:omg.org/CORBA/Container:1.0', 'Container');

# IDL:omg.org/CORBA/Container/Description:1.0
package CORBA::Container::Description;
@CORBA::Container::Description::ISA=qw(CORBA::_Struct);
$CORBA::Container::Description::_tc = CORBA::TypeCode::_create_struct_tc('IDL:omg.org/CORBA/Container/Description:1.0', 'Description', ['contained_object' => $CORBA::Contained::_tc, 'kind' => $CORBA::DefinitionKind::_tc, 'value' => $CORBA::_tc_any]);

# IDL:omg.org/CORBA/Container/DescriptionSeq:1.0
package CORBA::Container::DescriptionSeq;
$CORBA::Container::DescriptionSeq::_tc = CORBA::TypeCode::_create_sequence_tc(0, $CORBA::Container::Description::_tc);

# IDL:omg.org/CORBA/IDLType:1.0
package CORBA::IDLType;
$CORBA::IDLType::_tc = CORBA::TypeCode::_create_interface_tc('IDL:omg.org/CORBA/IDLType:1.0', 'IDLType');

# IDL:omg.org/CORBA/PrimitiveKind:1.0
package CORBA::PrimitiveKind;
$CORBA::PrimitiveKind::_tc = CORBA::TypeCode::_create_enum_tc('IDL:omg.org/CORBA/PrimitiveKind:1.0', 'PrimitiveKind', ['pk_null', 'pk_void', 'pk_short', 'pk_long', 'pk_ushort', 'pk_ulong', 'pk_float', 'pk_double', 'pk_boolean', 'pk_char', 'pk_octet', 'pk_any', 'pk_TypeCode', 'pk_Principal', 'pk_string', 'pk_objref']);
sub pk_null () {0}
sub pk_void () {1}
sub pk_short () {2}
sub pk_long () {3}
sub pk_ushort () {4}
sub pk_ulong () {5}
sub pk_float () {6}
sub pk_double () {7}
sub pk_boolean () {8}
sub pk_char () {9}
sub pk_octet () {10}
sub pk_any () {11}
sub pk_TypeCode () {12}
sub pk_Principal () {13}
sub pk_string () {14}
sub pk_objref () {15}

# IDL:omg.org/CORBA/Repository:1.0
package CORBA::Repository;
$CORBA::Repository::_tc = CORBA::TypeCode::_create_interface_tc('IDL:omg.org/CORBA/Repository:1.0', 'Repository');

# IDL:omg.org/CORBA/ModuleDef:1.0
package CORBA::ModuleDef;
$CORBA::ModuleDef::_tc = CORBA::TypeCode::_create_interface_tc('IDL:omg.org/CORBA/ModuleDef:1.0', 'ModuleDef');

# IDL:omg.org/CORBA/ModuleDescription:1.0
package CORBA::ModuleDescription;
@CORBA::ModuleDescription::ISA=qw(CORBA::_Struct);
$CORBA::ModuleDescription::_tc = CORBA::TypeCode::_create_struct_tc('IDL:omg.org/CORBA/ModuleDescription:1.0', 'ModuleDescription', ['name' => $CORBA::Identifier::_tc, 'id' => $CORBA::RepositoryId::_tc, 'defined_in' => $CORBA::RepositoryId::_tc, 'version' => $CORBA::VersionSpec::_tc]);

# IDL:omg.org/CORBA/ConstantDef:1.0
package CORBA::ConstantDef;
$CORBA::ConstantDef::_tc = CORBA::TypeCode::_create_interface_tc('IDL:omg.org/CORBA/ConstantDef:1.0', 'ConstantDef');

# IDL:omg.org/CORBA/ConstantDescription:1.0
package CORBA::ConstantDescription;
@CORBA::ConstantDescription::ISA=qw(CORBA::_Struct);
$CORBA::ConstantDescription::_tc = CORBA::TypeCode::_create_struct_tc('IDL:omg.org/CORBA/ConstantDescription:1.0', 'ConstantDescription', ['name' => $CORBA::Identifier::_tc, 'id' => $CORBA::RepositoryId::_tc, 'defined_in' => $CORBA::RepositoryId::_tc, 'version' => $CORBA::VersionSpec::_tc, 'type' => $CORBA::_tc_TypeCode, 'value' => $CORBA::_tc_any]);

# IDL:omg.org/CORBA/TypedefDef:1.0
package CORBA::TypedefDef;
$CORBA::TypedefDef::_tc = CORBA::TypeCode::_create_interface_tc('IDL:omg.org/CORBA/TypedefDef:1.0', 'TypedefDef');

# IDL:omg.org/CORBA/TypeDescription:1.0
package CORBA::TypeDescription;
@CORBA::TypeDescription::ISA=qw(CORBA::_Struct);
$CORBA::TypeDescription::_tc = CORBA::TypeCode::_create_struct_tc('IDL:omg.org/CORBA/TypeDescription:1.0', 'TypeDescription', ['name' => $CORBA::Identifier::_tc, 'id' => $CORBA::RepositoryId::_tc, 'defined_in' => $CORBA::RepositoryId::_tc, 'version' => $CORBA::VersionSpec::_tc, 'type' => $CORBA::_tc_TypeCode]);

# IDL:omg.org/CORBA/StructDef:1.0
package CORBA::StructDef;
$CORBA::StructDef::_tc = CORBA::TypeCode::_create_interface_tc('IDL:omg.org/CORBA/StructDef:1.0', 'StructDef');

# IDL:omg.org/CORBA/UnionDef:1.0
package CORBA::UnionDef;
$CORBA::UnionDef::_tc = CORBA::TypeCode::_create_interface_tc('IDL:omg.org/CORBA/UnionDef:1.0', 'UnionDef');

# IDL:omg.org/CORBA/EnumDef:1.0
package CORBA::EnumDef;
$CORBA::EnumDef::_tc = CORBA::TypeCode::_create_interface_tc('IDL:omg.org/CORBA/EnumDef:1.0', 'EnumDef');

# IDL:omg.org/CORBA/AliasDef:1.0
package CORBA::AliasDef;
$CORBA::AliasDef::_tc = CORBA::TypeCode::_create_interface_tc('IDL:omg.org/CORBA/AliasDef:1.0', 'AliasDef');

# IDL:omg.org/CORBA/PrimitiveDef:1.0
package CORBA::PrimitiveDef;
$CORBA::PrimitiveDef::_tc = CORBA::TypeCode::_create_interface_tc('IDL:omg.org/CORBA/PrimitiveDef:1.0', 'PrimitiveDef');

# IDL:omg.org/CORBA/StringDef:1.0
package CORBA::StringDef;
$CORBA::StringDef::_tc = CORBA::TypeCode::_create_interface_tc('IDL:omg.org/CORBA/StringDef:1.0', 'StringDef');

# IDL:omg.org/CORBA/SequenceDef:1.0
package CORBA::SequenceDef;
$CORBA::SequenceDef::_tc = CORBA::TypeCode::_create_interface_tc('IDL:omg.org/CORBA/SequenceDef:1.0', 'SequenceDef');

# IDL:omg.org/CORBA/ArrayDef:1.0
package CORBA::ArrayDef;
$CORBA::ArrayDef::_tc = CORBA::TypeCode::_create_interface_tc('IDL:omg.org/CORBA/ArrayDef:1.0', 'ArrayDef');

# IDL:omg.org/CORBA/ExceptionDef:1.0
package CORBA::ExceptionDef;
$CORBA::ExceptionDef::_tc = CORBA::TypeCode::_create_interface_tc('IDL:omg.org/CORBA/ExceptionDef:1.0', 'ExceptionDef');

# IDL:omg.org/CORBA/ExceptionDescription:1.0
package CORBA::ExceptionDescription;
@CORBA::ExceptionDescription::ISA=qw(CORBA::_Struct);
$CORBA::ExceptionDescription::_tc = CORBA::TypeCode::_create_struct_tc('IDL:omg.org/CORBA/ExceptionDescription:1.0', 'ExceptionDescription', ['name' => $CORBA::Identifier::_tc, 'id' => $CORBA::RepositoryId::_tc, 'defined_in' => $CORBA::RepositoryId::_tc, 'version' => $CORBA::VersionSpec::_tc, 'type' => $CORBA::_tc_TypeCode]);

# IDL:omg.org/CORBA/AttributeMode:1.0
package CORBA::AttributeMode;
$CORBA::AttributeMode::_tc = CORBA::TypeCode::_create_enum_tc('IDL:omg.org/CORBA/AttributeMode:1.0', 'AttributeMode', ['ATTR_NORMAL', 'ATTR_READONLY']);
sub ATTR_NORMAL () {0}
sub ATTR_READONLY () {1}

# IDL:omg.org/CORBA/AttributeDef:1.0
package CORBA::AttributeDef;
$CORBA::AttributeDef::_tc = CORBA::TypeCode::_create_interface_tc('IDL:omg.org/CORBA/AttributeDef:1.0', 'AttributeDef');

# IDL:omg.org/CORBA/AttributeDescription:1.0
package CORBA::AttributeDescription;
@CORBA::AttributeDescription::ISA=qw(CORBA::_Struct);
$CORBA::AttributeDescription::_tc = CORBA::TypeCode::_create_struct_tc('IDL:omg.org/CORBA/AttributeDescription:1.0', 'AttributeDescription', ['name' => $CORBA::Identifier::_tc, 'id' => $CORBA::RepositoryId::_tc, 'defined_in' => $CORBA::RepositoryId::_tc, 'version' => $CORBA::VersionSpec::_tc, 'type' => $CORBA::_tc_TypeCode, 'mode' => $CORBA::AttributeMode::_tc]);

# IDL:omg.org/CORBA/OperationMode:1.0
package CORBA::OperationMode;
$CORBA::OperationMode::_tc = CORBA::TypeCode::_create_enum_tc('IDL:omg.org/CORBA/OperationMode:1.0', 'OperationMode', ['OP_NORMAL', 'OP_ONEWAY']);
sub OP_NORMAL () {0}
sub OP_ONEWAY () {1}

# IDL:omg.org/CORBA/ParameterMode:1.0
package CORBA::ParameterMode;
$CORBA::ParameterMode::_tc = CORBA::TypeCode::_create_enum_tc('IDL:omg.org/CORBA/ParameterMode:1.0', 'ParameterMode', ['PARAM_IN', 'PARAM_OUT', 'PARAM_INOUT']);
sub PARAM_IN () {0}
sub PARAM_OUT () {1}
sub PARAM_INOUT () {2}

# IDL:omg.org/CORBA/ParameterDescription:1.0
package CORBA::ParameterDescription;
@CORBA::ParameterDescription::ISA=qw(CORBA::_Struct);
$CORBA::ParameterDescription::_tc = CORBA::TypeCode::_create_struct_tc('IDL:omg.org/CORBA/ParameterDescription:1.0', 'ParameterDescription', ['name' => $CORBA::Identifier::_tc, 'type' => $CORBA::_tc_TypeCode, 'type_def' => $CORBA::IDLType::_tc, 'mode' => $CORBA::ParameterMode::_tc]);

# IDL:omg.org/CORBA/ParDescriptionSeq:1.0
package CORBA::ParDescriptionSeq;
$CORBA::ParDescriptionSeq::_tc = CORBA::TypeCode::_create_sequence_tc(0, $CORBA::ParameterDescription::_tc);

# IDL:omg.org/CORBA/ContextIdentifier:1.0
package CORBA::ContextIdentifier;
$CORBA::ContextIdentifier::_tc = $CORBA::Identifier::_tc;

# IDL:omg.org/CORBA/ContextIdSeq:1.0
package CORBA::ContextIdSeq;
$CORBA::ContextIdSeq::_tc = CORBA::TypeCode::_create_sequence_tc(0, $CORBA::ContextIdentifier::_tc);

# IDL:omg.org/CORBA/ExceptionDefSeq:1.0
package CORBA::ExceptionDefSeq;
$CORBA::ExceptionDefSeq::_tc = CORBA::TypeCode::_create_sequence_tc(0, $CORBA::ExceptionDef::_tc);

# IDL:omg.org/CORBA/ExcDescriptionSeq:1.0
package CORBA::ExcDescriptionSeq;
$CORBA::ExcDescriptionSeq::_tc = CORBA::TypeCode::_create_sequence_tc(0, $CORBA::ExceptionDescription::_tc);

# IDL:omg.org/CORBA/OperationDef:1.0
package CORBA::OperationDef;
$CORBA::OperationDef::_tc = CORBA::TypeCode::_create_interface_tc('IDL:omg.org/CORBA/OperationDef:1.0', 'OperationDef');

# IDL:omg.org/CORBA/OperationDescription:1.0
package CORBA::OperationDescription;
@CORBA::OperationDescription::ISA=qw(CORBA::_Struct);
$CORBA::OperationDescription::_tc = CORBA::TypeCode::_create_struct_tc('IDL:omg.org/CORBA/OperationDescription:1.0', 'OperationDescription', ['name' => $CORBA::Identifier::_tc, 'id' => $CORBA::RepositoryId::_tc, 'defined_in' => $CORBA::RepositoryId::_tc, 'version' => $CORBA::VersionSpec::_tc, 'result' => $CORBA::_tc_TypeCode, 'mode' => $CORBA::OperationMode::_tc, 'contexts' => $CORBA::ContextIdSeq::_tc, 'parameters' => $CORBA::ParDescriptionSeq::_tc, 'exceptions' => $CORBA::ExcDescriptionSeq::_tc]);

# IDL:omg.org/CORBA/RepositoryIdSeq:1.0
package CORBA::RepositoryIdSeq;
$CORBA::RepositoryIdSeq::_tc = CORBA::TypeCode::_create_sequence_tc(0, $CORBA::RepositoryId::_tc);

# IDL:omg.org/CORBA/OpDescriptionSeq:1.0
package CORBA::OpDescriptionSeq;
$CORBA::OpDescriptionSeq::_tc = CORBA::TypeCode::_create_sequence_tc(0, $CORBA::OperationDescription::_tc);

# IDL:omg.org/CORBA/AttrDescriptionSeq:1.0
package CORBA::AttrDescriptionSeq;
$CORBA::AttrDescriptionSeq::_tc = CORBA::TypeCode::_create_sequence_tc(0, $CORBA::AttributeDescription::_tc);

# IDL:omg.org/CORBA/InterfaceDef/FullInterfaceDescription:1.0
package CORBA::InterfaceDef::FullInterfaceDescription;
@CORBA::InterfaceDef::FullInterfaceDescription::ISA=qw(CORBA::_Struct);
$CORBA::InterfaceDef::FullInterfaceDescription::_tc = CORBA::TypeCode::_create_struct_tc('IDL:omg.org/CORBA/InterfaceDef/FullInterfaceDescription:1.0', 'FullInterfaceDescription', ['name' => $CORBA::Identifier::_tc, 'id' => $CORBA::RepositoryId::_tc, 'defined_in' => $CORBA::RepositoryId::_tc, 'version' => $CORBA::VersionSpec::_tc, 'operations' => $CORBA::OpDescriptionSeq::_tc, 'attributes' => $CORBA::AttrDescriptionSeq::_tc, 'base_interfaces' => $CORBA::RepositoryIdSeq::_tc, 'type' => $CORBA::_tc_TypeCode]);

# IDL:omg.org/CORBA/InterfaceDescription:1.0
package CORBA::InterfaceDescription;
@CORBA::InterfaceDescription::ISA=qw(CORBA::_Struct);
$CORBA::InterfaceDescription::_tc = CORBA::TypeCode::_create_struct_tc('IDL:omg.org/CORBA/InterfaceDescription:1.0', 'InterfaceDescription', ['name' => $CORBA::Identifier::_tc, 'id' => $CORBA::RepositoryId::_tc, 'defined_in' => $CORBA::RepositoryId::_tc, 'version' => $CORBA::VersionSpec::_tc, 'base_interfaces' => $CORBA::RepositoryIdSeq::_tc]);



1;
