# $Id: TCKind.pm,v 1.1.1.1 1997/05/17 11:47:05 schuller Exp $
# Copyright (c) 1997 Lunatech Research / Bart Schuller <schuller@lunatech.com>
# See the file "Artistic" in the distribution for licensing and
# (lack of) warranties.

package COPE::CORBA::TCKind;
sub import {
    shift;
    my $callpkg = caller(0);
    CORBA::TCKind->export($callpkg, @_);
}

package CORBA::TCKind;
require Exporter;
@ISA = qw(Exporter);
@EXPORT = qw(
    tk_null tk_void tk_short tk_long tk_ushort tk_ulong tk_float tk_double
    tk_boolean tk_char tk_octet tk_any tk_TypeCode tk_Principal tk_objref
    tk_struct tk_union tk_enum tk_string tk_sequence tk_array tk_alias
    tk_except );

# enum TCKind
sub tk_null () { 0 }
sub tk_void () { 1 }
sub tk_short () { 2 }
sub tk_long () { 3 }
sub tk_ushort () { 4 }
sub tk_ulong () { 5 }
sub tk_float () { 6 }
sub tk_double () { 7 }
sub tk_boolean () { 8 }
sub tk_char () { 9 }
sub tk_octet () { 10 }
sub tk_any () { 11 }
sub tk_TypeCode () { 12 }
sub tk_Principal () { 13 }
sub tk_objref () { 14 }
sub tk_struct () { 15 }
sub tk_union () { 16 }
sub tk_enum () { 17 }
sub tk_string () { 18 }
sub tk_sequence () { 19 }
sub tk_array () { 20 }
sub tk_alias () { 21 }
sub tk_except () { 22 }

1;
