# $Id: Exception.pm,v 1.2 1997/07/31 11:03:53 schuller Exp $
# Copyright (c) 1997 Secure Computing Corporation
# Copyright (c) 1997 Lunatech Research
# See the file "Artistic" in the distribution for licensing and
# (lack of) warranties.

# The standard CORBA exception types

use strict;
use COPE::CORBA::TypeCode;

# Re-export try, catch and throw
package COPE::CORBA::Exception;
use Experimental::Exception;
@COPE::CORBA::Exception::ISA = qw(Experimental::Exception);
@COPE::CORBA::Exception::EXPORT = qw(&try &catch &throw);

# The base exception type; every CORBA exception inherits from this
package CORBA::Exception;
@CORBA::Exception::ISA=qw(Experimental::Exception);
$CORBA::Exception::_tc = CORBA::TypeCode::_create_exception_tc('IDL:omg.org/CORBA/Exception:1.0', 'Exception', []);


# User exceptions.  All IDL defined exceptions inherit from this.
package CORBA::UserException;
@CORBA::UserException::ISA=qw(CORBA::Exception);
$CORBA::UserException::_tc = CORBA::TypeCode::_create_exception_tc('IDL:omg.org/CORBA/UserException:1.0', 'UserException', []);


# System exceptions.  These correspond to the IDL definition:
#
# module CORBA {
#   enum CompletionStatus {COMPLETED_YES, COMPLETED_NO, COMPLETED_MAYBE};
#   exception SystemException : Exception {
#   	ulong minor;		// impl. defined minor number
#   	CompletionStatus completed;
#   };

package CORBA::CompletionStatus;
$CORBA::CompletionStatus::_tc = CORBA::TypeCode::_create_enum_tc('IDL:omg.org/CORBA/CompletionStatus:1.0', 'CompletionStatus', ['COMPLETED_YES', 'COMPLETED_NO', 'COMPLETED_MAYBE']);
sub COMPLETED_YES () {0}
sub COMPLETED_NO () {1}
sub COMPLETED_MAYBE () {2}

package CORBA::SystemException;
@CORBA::SystemException::ISA=qw(CORBA::Exception);
$CORBA::SystemException::_tc = CORBA::TypeCode::_create_exception_tc('IDL:omg.org/CORBA/SystemException:1.0', 'SystemException', ['minor' => $CORBA::_tc_ulong, 'completed' => $CORBA::CompletionStatus::_tc]);


# The defined CORBA system exceptions
package CORBA::UNKNOWN;
@CORBA::UNKNOWN::ISA=qw(CORBA::SystemException);
$CORBA::UNKNOWN::_tc = CORBA::TypeCode::_create_exception_tc('IDL:omg.org/CORBA/UNKNOWN:1.0', 'UNKNOWN', ['minor' => $CORBA::_tc_ulong, 'completed' => $CORBA::CompletionStatus::_tc]);

package CORBA::BAD_PARAM;
@CORBA::BAD_PARAM::ISA=qw(CORBA::SystemException);
$CORBA::BAD_PARAM::_tc = CORBA::TypeCode::_create_exception_tc('IDL:omg.org/CORBA/BAD_PARAM:1.0', 'BAD_PARAM', ['minor' => $CORBA::_tc_ulong, 'completed' => $CORBA::CompletionStatus::_tc]);

package CORBA::NO_MEMORY;
@CORBA::NO_MEMORY::ISA=qw(CORBA::SystemException);
$CORBA::NO_MEMORY::_tc = CORBA::TypeCode::_create_exception_tc('IDL:omg.org/CORBA/NO_MEMORY:1.0', 'NO_MEMORY', ['minor' => $CORBA::_tc_ulong, 'completed' => $CORBA::CompletionStatus::_tc]);

package CORBA::IMP_LIMIT;
@CORBA::IMP_LIMIT::ISA=qw(CORBA::SystemException);
$CORBA::IMP_LIMIT::_tc = CORBA::TypeCode::_create_exception_tc('IDL:omg.org/CORBA/IMP_LIMIT:1.0', 'IMP_LIMIT', ['minor' => $CORBA::_tc_ulong, 'completed' => $CORBA::CompletionStatus::_tc]);

package CORBA::COMM_FAILURE;
@CORBA::COMM_FAILURE::ISA=qw(CORBA::SystemException);
$CORBA::COMM_FAILURE::_tc = CORBA::TypeCode::_create_exception_tc('IDL:omg.org/CORBA/COMM_FAILURE:1.0', 'COMM_FAILURE', ['minor' => $CORBA::_tc_ulong, 'completed' => $CORBA::CompletionStatus::_tc]);

package CORBA::INV_OBJREF;
@CORBA::INV_OBJREF::ISA=qw(CORBA::SystemException);
$CORBA::INV_OBJREF::_tc = CORBA::TypeCode::_create_exception_tc('IDL:omg.org/CORBA/INV_OBJREF:1.0', 'INV_OBJREF', ['minor' => $CORBA::_tc_ulong, 'completed' => $CORBA::CompletionStatus::_tc]);

package CORBA::NO_PERMISSION;
@CORBA::NO_PERMISSION::ISA=qw(CORBA::SystemException);
$CORBA::NO_PERMISSION::_tc = CORBA::TypeCode::_create_exception_tc('IDL:omg.org/CORBA/NO_PERMISSION:1.0', 'NO_PERMISSION', ['minor' => $CORBA::_tc_ulong, 'completed' => $CORBA::CompletionStatus::_tc]);

package CORBA::INTERNAL;
@CORBA::INTERNAL::ISA=qw(CORBA::SystemException);
$CORBA::INTERNAL::_tc = CORBA::TypeCode::_create_exception_tc('IDL:omg.org/CORBA/INTERNAL:1.0', 'INTERNAL', ['minor' => $CORBA::_tc_ulong, 'completed' => $CORBA::CompletionStatus::_tc]);

package CORBA::MARSHAL;
@CORBA::MARSHAL::ISA=qw(CORBA::SystemException);
$CORBA::MARSHAL::_tc = CORBA::TypeCode::_create_exception_tc('IDL:omg.org/CORBA/MARSHAL:1.0', 'MARSHAL', ['minor' => $CORBA::_tc_ulong, 'completed' => $CORBA::CompletionStatus::_tc]);

package CORBA::INITIALIZE;
@CORBA::INITIALIZE::ISA=qw(CORBA::SystemException);
$CORBA::INITIALIZE::_tc = CORBA::TypeCode::_create_exception_tc('IDL:omg.org/CORBA/INITIALIZE:1.0', 'INITIALIZE', ['minor' => $CORBA::_tc_ulong, 'completed' => $CORBA::CompletionStatus::_tc]);

package CORBA::NO_IMPLEMENT;
@CORBA::NO_IMPLEMENT::ISA=qw(CORBA::SystemException);
$CORBA::NO_IMPLEMENT::_tc = CORBA::TypeCode::_create_exception_tc('IDL:omg.org/CORBA/NO_IMPLEMENT:1.0', 'NO_IMPLEMENT', ['minor' => $CORBA::_tc_ulong, 'completed' => $CORBA::CompletionStatus::_tc]);

package CORBA::BAD_TYPECODE;
@CORBA::BAD_TYPECODE::ISA=qw(CORBA::SystemException);
$CORBA::BAD_TYPECODE::_tc = CORBA::TypeCode::_create_exception_tc('IDL:omg.org/CORBA/BAD_TYPECODE:1.0', 'BAD_TYPECODE', ['minor' => $CORBA::_tc_ulong, 'completed' => $CORBA::CompletionStatus::_tc]);

package CORBA::BAD_OPERATION;
@CORBA::BAD_OPERATION::ISA=qw(CORBA::SystemException);
$CORBA::BAD_OPERATION::_tc = CORBA::TypeCode::_create_exception_tc('IDL:omg.org/CORBA/BAD_OPERATION:1.0', 'BAD_OPERATION', ['minor' => $CORBA::_tc_ulong, 'completed' => $CORBA::CompletionStatus::_tc]);

package CORBA::NO_RESOURCES;
@CORBA::NO_RESOURCES::ISA=qw(CORBA::SystemException);
$CORBA::NO_RESOURCES::_tc = CORBA::TypeCode::_create_exception_tc('IDL:omg.org/CORBA/NO_RESOURCES:1.0', 'NO_RESOURCES', ['minor' => $CORBA::_tc_ulong, 'completed' => $CORBA::CompletionStatus::_tc]);

package CORBA::NO_RESPONSE;
@CORBA::NO_RESPONSE::ISA=qw(CORBA::SystemException);
$CORBA::NO_RESPONSE::_tc = CORBA::TypeCode::_create_exception_tc('IDL:omg.org/CORBA/NO_RESPONSE:1.0', 'NO_RESPONSE', ['minor' => $CORBA::_tc_ulong, 'completed' => $CORBA::CompletionStatus::_tc]);

package CORBA::PERSIST_STORE;
@CORBA::PERSIST_STORE::ISA=qw(CORBA::SystemException);
$CORBA::PERSIST_STORE::_tc = CORBA::TypeCode::_create_exception_tc('IDL:omg.org/CORBA/PERSIST_STORE:1.0', 'PERSIST_STORE', ['minor' => $CORBA::_tc_ulong, 'completed' => $CORBA::CompletionStatus::_tc]);

package CORBA::BAD_INV_ORDER;
@CORBA::BAD_INV_ORDER::ISA=qw(CORBA::SystemException);
$CORBA::BAD_INV_ORDER::_tc = CORBA::TypeCode::_create_exception_tc('IDL:omg.org/CORBA/BAD_INV_ORDER:1.0', 'BAD_INV_ORDER', ['minor' => $CORBA::_tc_ulong, 'completed' => $CORBA::CompletionStatus::_tc]);

package CORBA::TRANSIENT;
@CORBA::TRANSIENT::ISA=qw(CORBA::SystemException);
$CORBA::TRANSIENT::_tc = CORBA::TypeCode::_create_exception_tc('IDL:omg.org/CORBA/TRANSIENT:1.0', 'TRANSIENT', ['minor' => $CORBA::_tc_ulong, 'completed' => $CORBA::CompletionStatus::_tc]);

package CORBA::FREE_MEM;
@CORBA::FREE_MEM::ISA=qw(CORBA::SystemException);
$CORBA::FREE_MEM::_tc = CORBA::TypeCode::_create_exception_tc('IDL:omg.org/CORBA/FREE_MEM:1.0', 'FREE_MEM', ['minor' => $CORBA::_tc_ulong, 'completed' => $CORBA::CompletionStatus::_tc]);

package CORBA::INV_IDENT;
@CORBA::INV_IDENT::ISA=qw(CORBA::SystemException);
$CORBA::INV_IDENT::_tc = CORBA::TypeCode::_create_exception_tc('IDL:omg.org/CORBA/INV_IDENT:1.0', 'INV_IDENT', ['minor' => $CORBA::_tc_ulong, 'completed' => $CORBA::CompletionStatus::_tc]);

package CORBA::INV_FLAG;
@CORBA::INV_FLAG::ISA=qw(CORBA::SystemException);
$CORBA::INV_FLAG::_tc = CORBA::TypeCode::_create_exception_tc('IDL:omg.org/CORBA/INV_FLAG:1.0', 'INV_FLAG', ['minor' => $CORBA::_tc_ulong, 'completed' => $CORBA::CompletionStatus::_tc]);

package CORBA::INTF_REPOS;
@CORBA::INTF_REPOS::ISA=qw(CORBA::SystemException);
$CORBA::INTF_REPOS::_tc = CORBA::TypeCode::_create_exception_tc('IDL:omg.org/CORBA/INTF_REPOS:1.0', 'INTF_REPOS', ['minor' => $CORBA::_tc_ulong, 'completed' => $CORBA::CompletionStatus::_tc]);

package CORBA::BAD_CONTEXT;
@CORBA::BAD_CONTEXT::ISA=qw(CORBA::SystemException);
$CORBA::BAD_CONTEXT::_tc = CORBA::TypeCode::_create_exception_tc('IDL:omg.org/CORBA/BAD_CONTEXT:1.0', 'BAD_CONTEXT', ['minor' => $CORBA::_tc_ulong, 'completed' => $CORBA::CompletionStatus::_tc]);

package CORBA::OBJ_ADAPTER;
@CORBA::OBJ_ADAPTER::ISA=qw(CORBA::SystemException);
$CORBA::OBJ_ADAPTER::_tc = CORBA::TypeCode::_create_exception_tc('IDL:omg.org/CORBA/OBJ_ADAPTER:1.0', 'OBJ_ADAPTER', ['minor' => $CORBA::_tc_ulong, 'completed' => $CORBA::CompletionStatus::_tc]);

package CORBA::DATA_CONVERSION;
@CORBA::DATA_CONVERSION::ISA=qw(CORBA::SystemException);
$CORBA::DATA_CONVERSION::_tc = CORBA::TypeCode::_create_exception_tc('IDL:omg.org/CORBA/DATA_CONVERSION:1.0', 'DATA_CONVERSION', ['minor' => $CORBA::_tc_ulong, 'completed' => $CORBA::CompletionStatus::_tc]);

package CORBA::OBJECT_NOT_EXIST;
@CORBA::OBJECT_NOT_EXIST::ISA=qw(CORBA::SystemException);
$CORBA::OBJECT_NOT_EXIST::_tc = CORBA::TypeCode::_create_exception_tc('IDL:omg.org/CORBA/OBJECT_NOT_EXIST:1.0', 'OBJECT_NOT_EXIST', ['minor' => $CORBA::_tc_ulong, 'completed' => $CORBA::CompletionStatus::_tc]);


1;
