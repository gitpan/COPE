# $Id: IR.pm,v 1.2 1997/05/23 12:34:42 schuller Exp $
# Copyright (c) 1997 Lunatech Research / Bart Schuller <schuller@lunatech.com>
# See the file "Artistic" in the distribution for licensing and
# (lack of) warranties.

use COPE::IR_types;

# IDL:omg.org/CORBA/IRObject:1.0
package CORBA::IRObject;
@CORBA::IRObject::ISA=qw(CORBA::Object);
# IDL:omg.org/CORBA/IRObject/def_kind:1.0
sub def_kind {
    my($self,@rest) = @_;
    return $self->_attribute('def_kind', $CORBA::DefinitionKind::_tc, @rest);
}

# IDL:omg.org/CORBA/IRObject/destroy:1.0
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

# IDL:omg.org/CORBA/Principal:1.0
package CORBA::Principal;
@CORBA::Principal::ISA=qw(CORBA::Object);
# IDL:omg.org/CORBA/Contained:1.0
package CORBA::Contained;
@CORBA::Contained::ISA=qw(CORBA::IRObject CORBA::Object);
# IDL:omg.org/CORBA/Contained/id:1.0
sub id {
    my($self,@rest) = @_;
    return $self->_attribute('id', $CORBA::RepositoryId::_tc, @rest);
}

# IDL:omg.org/CORBA/Contained/name:1.0
sub name {
    my($self,@rest) = @_;
    return $self->_attribute('name', $CORBA::Identifier::_tc, @rest);
}

# IDL:omg.org/CORBA/Contained/version:1.0
sub version {
    my($self,@rest) = @_;
    return $self->_attribute('version', $CORBA::VersionSpec::_tc, @rest);
}

# IDL:omg.org/CORBA/Contained/defined_in:1.0
sub defined_in {
    my($self,@rest) = @_;
    return $self->_attribute('defined_in', $CORBA::Container::_tc, @rest);
}

# IDL:omg.org/CORBA/Contained/absolute_name:1.0
sub absolute_name {
    my($self,@rest) = @_;
    return $self->_attribute('absolute_name', $CORBA::ScopedName::_tc, @rest);
}

# IDL:omg.org/CORBA/Contained/containing_repository:1.0
sub containing_repository {
    my($self,@rest) = @_;
    return $self->_attribute('containing_repository', $CORBA::Repository::_tc, @rest);
}

# IDL:omg.org/CORBA/Contained/describe:1.0
sub describe {
    my($self) = @_;
    my $result_ = { _type => $CORBA::Contained::Description::_tc };
    my $request_ = $self->create_request(
        'operation' => 'describe',
        'arg_list'  => [
                       ],
        'result'    => $result_,
    );
    $request_->invoke(0);
    return $result_->{_value};
}

# IDL:omg.org/CORBA/Contained/move:1.0
sub move {
    my($self,$new_container,$new_name,$new_version) = @_;
    my $result_ = { _type => $CORBA::_tc_void };
    my $request_ = $self->create_request(
        'operation' => 'move',
        'arg_list'  => [
        { 'argument'  =>
          { _type  => $CORBA::Container::_tc, _value => $new_container },
          'arg_modes' => 0,
        },
        { 'argument'  =>
          { _type  => $CORBA::Identifier::_tc, _value => $new_name },
          'arg_modes' => 0,
        },
        { 'argument'  =>
          { _type  => $CORBA::VersionSpec::_tc, _value => $new_version },
          'arg_modes' => 0,
        },
                       ],
        'result'    => $result_,
    );
    $request_->invoke(0);
}

# IDL:omg.org/CORBA/Container:1.0
package CORBA::Container;
@CORBA::Container::ISA=qw(CORBA::IRObject CORBA::Object);
# IDL:omg.org/CORBA/Container/lookup:1.0
sub lookup {
    my($self,$search_name) = @_;
    my $result_ = { _type => $CORBA::Contained::_tc };
    my $request_ = $self->create_request(
        'operation' => 'lookup',
        'arg_list'  => [
        { 'argument'  =>
          { _type  => $CORBA::ScopedName::_tc, _value => $search_name },
          'arg_modes' => 0,
        },
                       ],
        'result'    => $result_,
    );
    $request_->invoke(0);
    return $result_->{_value};
}

# IDL:omg.org/CORBA/Container/contents:1.0
sub contents {
    my($self,$limit_type,$exclude_inherited) = @_;
    my $result_ = { _type => $CORBA::ContainedSeq::_tc };
    my $request_ = $self->create_request(
        'operation' => 'contents',
        'arg_list'  => [
        { 'argument'  =>
          { _type  => $CORBA::DefinitionKind::_tc, _value => $limit_type },
          'arg_modes' => 0,
        },
        { 'argument'  =>
          { _type  => $CORBA::_tc_boolean, _value => $exclude_inherited },
          'arg_modes' => 0,
        },
                       ],
        'result'    => $result_,
    );
    $request_->invoke(0);
    return $result_->{_value};
}

# IDL:omg.org/CORBA/Container/lookup_name:1.0
sub lookup_name {
    my($self,$search_name,$levels_to_search,$limit_type,$exclude_inherited) = @_;
    my $result_ = { _type => $CORBA::ContainedSeq::_tc };
    my $request_ = $self->create_request(
        'operation' => 'lookup_name',
        'arg_list'  => [
        { 'argument'  =>
          { _type  => $CORBA::Identifier::_tc, _value => $search_name },
          'arg_modes' => 0,
        },
        { 'argument'  =>
          { _type  => $CORBA::_tc_long, _value => $levels_to_search },
          'arg_modes' => 0,
        },
        { 'argument'  =>
          { _type  => $CORBA::DefinitionKind::_tc, _value => $limit_type },
          'arg_modes' => 0,
        },
        { 'argument'  =>
          { _type  => $CORBA::_tc_boolean, _value => $exclude_inherited },
          'arg_modes' => 0,
        },
                       ],
        'result'    => $result_,
    );
    $request_->invoke(0);
    return $result_->{_value};
}

# IDL:omg.org/CORBA/Container/describe_contents:1.0
sub describe_contents {
    my($self,$limit_type,$exclude_inherited,$max_returned_objs) = @_;
    my $result_ = { _type => $CORBA::Container::DescriptionSeq::_tc };
    my $request_ = $self->create_request(
        'operation' => 'describe_contents',
        'arg_list'  => [
        { 'argument'  =>
          { _type  => $CORBA::DefinitionKind::_tc, _value => $limit_type },
          'arg_modes' => 0,
        },
        { 'argument'  =>
          { _type  => $CORBA::_tc_boolean, _value => $exclude_inherited },
          'arg_modes' => 0,
        },
        { 'argument'  =>
          { _type  => $CORBA::_tc_long, _value => $max_returned_objs },
          'arg_modes' => 0,
        },
                       ],
        'result'    => $result_,
    );
    $request_->invoke(0);
    return $result_->{_value};
}

# IDL:omg.org/CORBA/Container/create_module:1.0
sub create_module {
    my($self,$id,$name,$version) = @_;
    my $result_ = { _type => $CORBA::ModuleDef::_tc };
    my $request_ = $self->create_request(
        'operation' => 'create_module',
        'arg_list'  => [
        { 'argument'  =>
          { _type  => $CORBA::RepositoryId::_tc, _value => $id },
          'arg_modes' => 0,
        },
        { 'argument'  =>
          { _type  => $CORBA::Identifier::_tc, _value => $name },
          'arg_modes' => 0,
        },
        { 'argument'  =>
          { _type  => $CORBA::VersionSpec::_tc, _value => $version },
          'arg_modes' => 0,
        },
                       ],
        'result'    => $result_,
    );
    $request_->invoke(0);
    return $result_->{_value};
}

# IDL:omg.org/CORBA/Container/create_constant:1.0
sub create_constant {
    my($self,$id,$name,$version,$type,$value) = @_;
    my $result_ = { _type => $CORBA::ConstantDef::_tc };
    my $request_ = $self->create_request(
        'operation' => 'create_constant',
        'arg_list'  => [
        { 'argument'  =>
          { _type  => $CORBA::RepositoryId::_tc, _value => $id },
          'arg_modes' => 0,
        },
        { 'argument'  =>
          { _type  => $CORBA::Identifier::_tc, _value => $name },
          'arg_modes' => 0,
        },
        { 'argument'  =>
          { _type  => $CORBA::VersionSpec::_tc, _value => $version },
          'arg_modes' => 0,
        },
        { 'argument'  =>
          { _type  => $CORBA::IDLType::_tc, _value => $type },
          'arg_modes' => 0,
        },
        { 'argument'  =>
          { _type  => $CORBA::_tc_any, _value => $value },
          'arg_modes' => 0,
        },
                       ],
        'result'    => $result_,
    );
    $request_->invoke(0);
    return $result_->{_value};
}

# IDL:omg.org/CORBA/Container/create_struct:1.0
sub create_struct {
    my($self,$id,$name,$version,$members) = @_;
    my $result_ = { _type => $CORBA::StructDef::_tc };
    my $request_ = $self->create_request(
        'operation' => 'create_struct',
        'arg_list'  => [
        { 'argument'  =>
          { _type  => $CORBA::RepositoryId::_tc, _value => $id },
          'arg_modes' => 0,
        },
        { 'argument'  =>
          { _type  => $CORBA::Identifier::_tc, _value => $name },
          'arg_modes' => 0,
        },
        { 'argument'  =>
          { _type  => $CORBA::VersionSpec::_tc, _value => $version },
          'arg_modes' => 0,
        },
        { 'argument'  =>
          { _type  => $CORBA::StructMemberSeq::_tc, _value => $members },
          'arg_modes' => 0,
        },
                       ],
        'result'    => $result_,
    );
    $request_->invoke(0);
    return $result_->{_value};
}

# IDL:omg.org/CORBA/Container/create_union:1.0
sub create_union {
    my($self,$id,$name,$version,$discriminator_type,$members) = @_;
    my $result_ = { _type => $CORBA::UnionDef::_tc };
    my $request_ = $self->create_request(
        'operation' => 'create_union',
        'arg_list'  => [
        { 'argument'  =>
          { _type  => $CORBA::RepositoryId::_tc, _value => $id },
          'arg_modes' => 0,
        },
        { 'argument'  =>
          { _type  => $CORBA::Identifier::_tc, _value => $name },
          'arg_modes' => 0,
        },
        { 'argument'  =>
          { _type  => $CORBA::VersionSpec::_tc, _value => $version },
          'arg_modes' => 0,
        },
        { 'argument'  =>
          { _type  => $CORBA::IDLType::_tc, _value => $discriminator_type },
          'arg_modes' => 0,
        },
        { 'argument'  =>
          { _type  => $CORBA::UnionMemberSeq::_tc, _value => $members },
          'arg_modes' => 0,
        },
                       ],
        'result'    => $result_,
    );
    $request_->invoke(0);
    return $result_->{_value};
}

# IDL:omg.org/CORBA/Container/create_enum:1.0
sub create_enum {
    my($self,$id,$name,$version,$members) = @_;
    my $result_ = { _type => $CORBA::EnumDef::_tc };
    my $request_ = $self->create_request(
        'operation' => 'create_enum',
        'arg_list'  => [
        { 'argument'  =>
          { _type  => $CORBA::RepositoryId::_tc, _value => $id },
          'arg_modes' => 0,
        },
        { 'argument'  =>
          { _type  => $CORBA::Identifier::_tc, _value => $name },
          'arg_modes' => 0,
        },
        { 'argument'  =>
          { _type  => $CORBA::VersionSpec::_tc, _value => $version },
          'arg_modes' => 0,
        },
        { 'argument'  =>
          { _type  => $CORBA::EnumMemberSeq::_tc, _value => $members },
          'arg_modes' => 0,
        },
                       ],
        'result'    => $result_,
    );
    $request_->invoke(0);
    return $result_->{_value};
}

# IDL:omg.org/CORBA/Container/create_alias:1.0
sub create_alias {
    my($self,$id,$name,$version,$original_type) = @_;
    my $result_ = { _type => $CORBA::AliasDef::_tc };
    my $request_ = $self->create_request(
        'operation' => 'create_alias',
        'arg_list'  => [
        { 'argument'  =>
          { _type  => $CORBA::RepositoryId::_tc, _value => $id },
          'arg_modes' => 0,
        },
        { 'argument'  =>
          { _type  => $CORBA::Identifier::_tc, _value => $name },
          'arg_modes' => 0,
        },
        { 'argument'  =>
          { _type  => $CORBA::VersionSpec::_tc, _value => $version },
          'arg_modes' => 0,
        },
        { 'argument'  =>
          { _type  => $CORBA::IDLType::_tc, _value => $original_type },
          'arg_modes' => 0,
        },
                       ],
        'result'    => $result_,
    );
    $request_->invoke(0);
    return $result_->{_value};
}

# IDL:omg.org/CORBA/Container/create_interface:1.0
sub create_interface {
    my($self,$id,$name,$version,$base_interfaces) = @_;
    my $result_ = { _type => $CORBA::InterfaceDef::_tc };
    my $request_ = $self->create_request(
        'operation' => 'create_interface',
        'arg_list'  => [
        { 'argument'  =>
          { _type  => $CORBA::RepositoryId::_tc, _value => $id },
          'arg_modes' => 0,
        },
        { 'argument'  =>
          { _type  => $CORBA::Identifier::_tc, _value => $name },
          'arg_modes' => 0,
        },
        { 'argument'  =>
          { _type  => $CORBA::VersionSpec::_tc, _value => $version },
          'arg_modes' => 0,
        },
        { 'argument'  =>
          { _type  => $CORBA::InterfaceDefSeq::_tc, _value => $base_interfaces },
          'arg_modes' => 0,
        },
                       ],
        'result'    => $result_,
    );
    $request_->invoke(0);
    return $result_->{_value};
}

# IDL:omg.org/CORBA/IDLType:1.0
package CORBA::IDLType;
@CORBA::IDLType::ISA=qw(CORBA::IRObject CORBA::Object);
# IDL:omg.org/CORBA/IDLType/type:1.0
sub type {
    my($self,@rest) = @_;
    return $self->_attribute('type', $CORBA::_tc_TypeCode, @rest);
}

# IDL:omg.org/CORBA/Repository:1.0
package CORBA::Repository;
@CORBA::Repository::ISA=qw(CORBA::Container CORBA::Object);
# IDL:omg.org/CORBA/Repository/lookup_id:1.0
sub lookup_id {
    my($self,$search_id) = @_;
    my $result_ = { _type => $CORBA::Contained::_tc };
    my $request_ = $self->create_request(
        'operation' => 'lookup_id',
        'arg_list'  => [
        { 'argument'  =>
          { _type  => $CORBA::RepositoryId::_tc, _value => $search_id },
          'arg_modes' => 0,
        },
                       ],
        'result'    => $result_,
    );
    $request_->invoke(0);
    return $result_->{_value};
}

# IDL:omg.org/CORBA/Repository/get_primitive:1.0
sub get_primitive {
    my($self,$kind) = @_;
    my $result_ = { _type => $CORBA::PrimitiveDef::_tc };
    my $request_ = $self->create_request(
        'operation' => 'get_primitive',
        'arg_list'  => [
        { 'argument'  =>
          { _type  => $CORBA::PrimitiveKind::_tc, _value => $kind },
          'arg_modes' => 0,
        },
                       ],
        'result'    => $result_,
    );
    $request_->invoke(0);
    return $result_->{_value};
}

# IDL:omg.org/CORBA/Repository/create_string:1.0
sub create_string {
    my($self,$bound) = @_;
    my $result_ = { _type => $CORBA::StringDef::_tc };
    my $request_ = $self->create_request(
        'operation' => 'create_string',
        'arg_list'  => [
        { 'argument'  =>
          { _type  => $CORBA::_tc_ulong, _value => $bound },
          'arg_modes' => 0,
        },
                       ],
        'result'    => $result_,
    );
    $request_->invoke(0);
    return $result_->{_value};
}

# IDL:omg.org/CORBA/Repository/create_sequence:1.0
sub create_sequence {
    my($self,$bound,$element_type) = @_;
    my $result_ = { _type => $CORBA::SequenceDef::_tc };
    my $request_ = $self->create_request(
        'operation' => 'create_sequence',
        'arg_list'  => [
        { 'argument'  =>
          { _type  => $CORBA::_tc_ulong, _value => $bound },
          'arg_modes' => 0,
        },
        { 'argument'  =>
          { _type  => $CORBA::IDLType::_tc, _value => $element_type },
          'arg_modes' => 0,
        },
                       ],
        'result'    => $result_,
    );
    $request_->invoke(0);
    return $result_->{_value};
}

# IDL:omg.org/CORBA/Repository/create_array:1.0
sub create_array {
    my($self,$length,$element_type) = @_;
    my $result_ = { _type => $CORBA::ArrayDef::_tc };
    my $request_ = $self->create_request(
        'operation' => 'create_array',
        'arg_list'  => [
        { 'argument'  =>
          { _type  => $CORBA::_tc_ulong, _value => $length },
          'arg_modes' => 0,
        },
        { 'argument'  =>
          { _type  => $CORBA::IDLType::_tc, _value => $element_type },
          'arg_modes' => 0,
        },
                       ],
        'result'    => $result_,
    );
    $request_->invoke(0);
    return $result_->{_value};
}

# IDL:omg.org/CORBA/ModuleDef:1.0
package CORBA::ModuleDef;
@CORBA::ModuleDef::ISA=qw(CORBA::Container CORBA::Contained CORBA::Object);
# IDL:omg.org/CORBA/ConstantDef:1.0
package CORBA::ConstantDef;
@CORBA::ConstantDef::ISA=qw(CORBA::Contained CORBA::Object);
# IDL:omg.org/CORBA/ConstantDef/type:1.0
sub type {
    my($self,@rest) = @_;
    return $self->_attribute('type', $CORBA::_tc_TypeCode, @rest);
}

# IDL:omg.org/CORBA/ConstantDef/type_def:1.0
sub type_def {
    my($self,@rest) = @_;
    return $self->_attribute('type_def', $CORBA::IDLType::_tc, @rest);
}

# IDL:omg.org/CORBA/ConstantDef/value:1.0
sub value {
    my($self,@rest) = @_;
    return $self->_attribute('value', $CORBA::_tc_any, @rest);
}

# IDL:omg.org/CORBA/TypedefDef:1.0
package CORBA::TypedefDef;
@CORBA::TypedefDef::ISA=qw(CORBA::Contained CORBA::IDLType CORBA::Object);
# IDL:omg.org/CORBA/StructDef:1.0
package CORBA::StructDef;
@CORBA::StructDef::ISA=qw(CORBA::TypedefDef CORBA::Object);
# IDL:omg.org/CORBA/StructDef/members:1.0
sub members {
    my($self,@rest) = @_;
    return $self->_attribute('members', $CORBA::StructMemberSeq::_tc, @rest);
}

# IDL:omg.org/CORBA/UnionDef:1.0
package CORBA::UnionDef;
@CORBA::UnionDef::ISA=qw(CORBA::TypedefDef CORBA::Object);
# IDL:omg.org/CORBA/UnionDef/discriminator_type:1.0
sub discriminator_type {
    my($self,@rest) = @_;
    return $self->_attribute('discriminator_type', $CORBA::_tc_TypeCode, @rest);
}

# IDL:omg.org/CORBA/UnionDef/discriminator_type_def:1.0
sub discriminator_type_def {
    my($self,@rest) = @_;
    return $self->_attribute('discriminator_type_def', $CORBA::IDLType::_tc, @rest);
}

# IDL:omg.org/CORBA/UnionDef/members:1.0
sub members {
    my($self,@rest) = @_;
    return $self->_attribute('members', $CORBA::UnionMemberSeq::_tc, @rest);
}

# IDL:omg.org/CORBA/EnumDef:1.0
package CORBA::EnumDef;
@CORBA::EnumDef::ISA=qw(CORBA::TypedefDef CORBA::Object);
# IDL:omg.org/CORBA/EnumDef/members:1.0
sub members {
    my($self,@rest) = @_;
    return $self->_attribute('members', $CORBA::EnumMemberSeq::_tc, @rest);
}

# IDL:omg.org/CORBA/AliasDef:1.0
package CORBA::AliasDef;
@CORBA::AliasDef::ISA=qw(CORBA::TypedefDef CORBA::Object);
# IDL:omg.org/CORBA/AliasDef/original_type_def:1.0
sub original_type_def {
    my($self,@rest) = @_;
    return $self->_attribute('original_type_def', $CORBA::IDLType::_tc, @rest);
}

# IDL:omg.org/CORBA/PrimitiveDef:1.0
package CORBA::PrimitiveDef;
@CORBA::PrimitiveDef::ISA=qw(CORBA::IDLType CORBA::Object);
# IDL:omg.org/CORBA/PrimitiveDef/kind:1.0
sub kind {
    my($self,@rest) = @_;
    return $self->_attribute('kind', $CORBA::PrimitiveKind::_tc, @rest);
}

# IDL:omg.org/CORBA/StringDef:1.0
package CORBA::StringDef;
@CORBA::StringDef::ISA=qw(CORBA::IDLType CORBA::Object);
# IDL:omg.org/CORBA/StringDef/bound:1.0
sub bound {
    my($self,@rest) = @_;
    return $self->_attribute('bound', $CORBA::_tc_ulong, @rest);
}

# IDL:omg.org/CORBA/SequenceDef:1.0
package CORBA::SequenceDef;
@CORBA::SequenceDef::ISA=qw(CORBA::IDLType CORBA::Object);
# IDL:omg.org/CORBA/SequenceDef/bound:1.0
sub bound {
    my($self,@rest) = @_;
    return $self->_attribute('bound', $CORBA::_tc_ulong, @rest);
}

# IDL:omg.org/CORBA/SequenceDef/element_type:1.0
sub element_type {
    my($self,@rest) = @_;
    return $self->_attribute('element_type', $CORBA::_tc_TypeCode, @rest);
}

# IDL:omg.org/CORBA/SequenceDef/element_type_def:1.0
sub element_type_def {
    my($self,@rest) = @_;
    return $self->_attribute('element_type_def', $CORBA::IDLType::_tc, @rest);
}

# IDL:omg.org/CORBA/ArrayDef:1.0
package CORBA::ArrayDef;
@CORBA::ArrayDef::ISA=qw(CORBA::IDLType CORBA::Object);
# IDL:omg.org/CORBA/ArrayDef/length:1.0
sub length {
    my($self,@rest) = @_;
    return $self->_attribute('length', $CORBA::_tc_ulong, @rest);
}

# IDL:omg.org/CORBA/ArrayDef/element_type:1.0
sub element_type {
    my($self,@rest) = @_;
    return $self->_attribute('element_type', $CORBA::_tc_TypeCode, @rest);
}

# IDL:omg.org/CORBA/ArrayDef/element_type_def:1.0
sub element_type_def {
    my($self,@rest) = @_;
    return $self->_attribute('element_type_def', $CORBA::IDLType::_tc, @rest);
}

# IDL:omg.org/CORBA/ExceptionDef:1.0
package CORBA::ExceptionDef;
@CORBA::ExceptionDef::ISA=qw(CORBA::Contained CORBA::Object);
# IDL:omg.org/CORBA/ExceptionDef/type:1.0
sub type {
    my($self,@rest) = @_;
    return $self->_attribute('type', $CORBA::_tc_TypeCode, @rest);
}

# IDL:omg.org/CORBA/ExceptionDef/members:1.0
sub members {
    my($self,@rest) = @_;
    return $self->_attribute('members', $CORBA::StructMemberSeq::_tc, @rest);
}

# IDL:omg.org/CORBA/AttributeDef:1.0
package CORBA::AttributeDef;
@CORBA::AttributeDef::ISA=qw(CORBA::Contained CORBA::Object);
# IDL:omg.org/CORBA/AttributeDef/type:1.0
sub type {
    my($self,@rest) = @_;
    return $self->_attribute('type', $CORBA::_tc_TypeCode, @rest);
}

# IDL:omg.org/CORBA/AttributeDef/type_def:1.0
sub type_def {
    my($self,@rest) = @_;
    return $self->_attribute('type_def', $CORBA::IDLType::_tc, @rest);
}

# IDL:omg.org/CORBA/AttributeDef/mode:1.0
sub mode {
    my($self,@rest) = @_;
    return $self->_attribute('mode', $CORBA::AttributeMode::_tc, @rest);
}

# IDL:omg.org/CORBA/OperationDef:1.0
package CORBA::OperationDef;
@CORBA::OperationDef::ISA=qw(CORBA::Contained CORBA::Object);
# IDL:omg.org/CORBA/OperationDef/result:1.0
sub result {
    my($self,@rest) = @_;
    return $self->_attribute('result', $CORBA::_tc_TypeCode, @rest);
}

# IDL:omg.org/CORBA/OperationDef/result_def:1.0
sub result_def {
    my($self,@rest) = @_;
    return $self->_attribute('result_def', $CORBA::IDLType::_tc, @rest);
}

# IDL:omg.org/CORBA/OperationDef/params:1.0
sub params {
    my($self,@rest) = @_;
    return $self->_attribute('params', $CORBA::ParDescriptionSeq::_tc, @rest);
}

# IDL:omg.org/CORBA/OperationDef/mode:1.0
sub mode {
    my($self,@rest) = @_;
    return $self->_attribute('mode', $CORBA::OperationMode::_tc, @rest);
}

# IDL:omg.org/CORBA/OperationDef/contexts:1.0
sub contexts {
    my($self,@rest) = @_;
    return $self->_attribute('contexts', $CORBA::ContextIdSeq::_tc, @rest);
}

# IDL:omg.org/CORBA/OperationDef/exceptions:1.0
sub exceptions {
    my($self,@rest) = @_;
    return $self->_attribute('exceptions', $CORBA::ExceptionDefSeq::_tc, @rest);
}

# IDL:omg.org/CORBA/InterfaceDef:1.0
package CORBA::InterfaceDef;
@CORBA::InterfaceDef::ISA=qw(CORBA::Container CORBA::Contained CORBA::IDLType CORBA::Object);
# IDL:omg.org/CORBA/InterfaceDef/base_interfaces:1.0
sub base_interfaces {
    my($self,@rest) = @_;
    return $self->_attribute('base_interfaces', $CORBA::InterfaceDefSeq::_tc, @rest);
}

# IDL:omg.org/CORBA/InterfaceDef/is_a:1.0
sub is_a {
    my($self,$interface_id) = @_;
    my $result_ = { _type => $CORBA::_tc_boolean };
    my $request_ = $self->create_request(
        'operation' => 'is_a',
        'arg_list'  => [
        { 'argument'  =>
          { _type  => $CORBA::RepositoryId::_tc, _value => $interface_id },
          'arg_modes' => 0,
        },
                       ],
        'result'    => $result_,
    );
    $request_->invoke(0);
    return $result_->{_value};
}

# IDL:omg.org/CORBA/InterfaceDef/describe_interface:1.0
sub describe_interface {
    my($self) = @_;
    my $result_ = { _type => $CORBA::InterfaceDef::FullInterfaceDescription::_tc };
    my $request_ = $self->create_request(
        'operation' => 'describe_interface',
        'arg_list'  => [
                       ],
        'result'    => $result_,
    );
    $request_->invoke(0);
    return $result_->{_value};
}

# IDL:omg.org/CORBA/InterfaceDef/create_attribute:1.0
sub create_attribute {
    my($self,$id,$name,$version,$type,$mode) = @_;
    my $result_ = { _type => $CORBA::AttributeDef::_tc };
    my $request_ = $self->create_request(
        'operation' => 'create_attribute',
        'arg_list'  => [
        { 'argument'  =>
          { _type  => $CORBA::RepositoryId::_tc, _value => $id },
          'arg_modes' => 0,
        },
        { 'argument'  =>
          { _type  => $CORBA::Identifier::_tc, _value => $name },
          'arg_modes' => 0,
        },
        { 'argument'  =>
          { _type  => $CORBA::VersionSpec::_tc, _value => $version },
          'arg_modes' => 0,
        },
        { 'argument'  =>
          { _type  => $CORBA::IDLType::_tc, _value => $type },
          'arg_modes' => 0,
        },
        { 'argument'  =>
          { _type  => $CORBA::AttributeMode::_tc, _value => $mode },
          'arg_modes' => 0,
        },
                       ],
        'result'    => $result_,
    );
    $request_->invoke(0);
    return $result_->{_value};
}

# IDL:omg.org/CORBA/InterfaceDef/create_operation:1.0
sub create_operation {
    my($self,$id,$name,$version,$result,$mode,$params,$exceptions,$contexts) = @_;
    my $result_ = { _type => $CORBA::OperationDef::_tc };
    my $request_ = $self->create_request(
        'operation' => 'create_operation',
        'arg_list'  => [
        { 'argument'  =>
          { _type  => $CORBA::RepositoryId::_tc, _value => $id },
          'arg_modes' => 0,
        },
        { 'argument'  =>
          { _type  => $CORBA::Identifier::_tc, _value => $name },
          'arg_modes' => 0,
        },
        { 'argument'  =>
          { _type  => $CORBA::VersionSpec::_tc, _value => $version },
          'arg_modes' => 0,
        },
        { 'argument'  =>
          { _type  => $CORBA::IDLType::_tc, _value => $result },
          'arg_modes' => 0,
        },
        { 'argument'  =>
          { _type  => $CORBA::OperationMode::_tc, _value => $mode },
          'arg_modes' => 0,
        },
        { 'argument'  =>
          { _type  => $CORBA::ParDescriptionSeq::_tc, _value => $params },
          'arg_modes' => 0,
        },
        { 'argument'  =>
          { _type  => $CORBA::ExceptionDefSeq::_tc, _value => $exceptions },
          'arg_modes' => 0,
        },
        { 'argument'  =>
          { _type  => $CORBA::ContextIdSeq::_tc, _value => $contexts },
          'arg_modes' => 0,
        },
                       ],
        'result'    => $result_,
    );
    $request_->invoke(0);
    return $result_->{_value};
}


1;
