# $Id: Test_impl.pm,v 1.3 1997/07/31 11:04:04 schuller Exp $
# Copyright (c) 1997 Lunatech Research / Bart Schuller <schuller@lunatech.com>
# See the file "Artistic" in the distribution for licensing and
# (lack of) warranties.

use strict;
use COPE::Test_types;

# IDL:Test/Test2:1.0
package Test::Test2_impl;
@Test::Test2_impl::ISA=qw();
use COPE::CORBA::Exception;

sub new {
    my($class,@args) = @_;
    my $self = {};
    return bless $self, $class;
}

sub check ($) {
    my($self) = @_;
    return 'ok';
}

sub etest ($) {
    my($self) = @_;
    throw new Test::Test2::AnException why => 'because', minor => 1;
}

sub help_brother ($$$) {
    my($self,$counter,$my_brother) = @_;
    print "help_brother with counter=$$counter\n";
    if (--$$counter > 0) {
        $my_brother->help_brother($counter, $self);
    }
}

sub anattr ($;$) {
    my($self,$newval) = @_;
    if (defined $newval) {
        $self->{'anattr'} = $newval;
    } else {
        return $self->{'anattr'};
    }
}

sub count ($) {
    my($self) = @_;
    return 15;
}

# IDL:Test/Test1:1.0
package Test::Test1_impl;
@Test::Test1_impl::ISA=qw();
sub new {
    my($class,@args) = @_;
    my $self = {};
    return bless $self, $class;
}

sub in_long ($$) {
    my($self,$along) = @_;
    return -$along;
}

sub in_string ($$) {
    my($self,$astring) = @_;
    return reverse $astring;
}

sub in_long_sequence ($$) {
    my($self,$asequence) = @_;
    return [reverse @$asequence];
}

sub in_octet_sequence ($$) {
    my($self,$asequence) = @_;
    return reverse $asequence;
}

sub in_struct ($$) {
    my($self,$astruct) = @_;
    return new Test::TestStruct astring => $astruct->{ashort},
                                ashort  => length($astruct->{astring});
}

sub in_array ($$) {
    my($self,$anarray) = @_;
    return [reverse @$anarray];
}

sub inout_long ($$) {
    my($self,$along) = @_;
    $$along *= -1;
}

sub inout_string ($$) {
    my($self,$astring) = @_;
    $$astring = reverse $$astring;
}

sub inout_long_sequence ($$) {
    my($self,$asequence) = @_;
    @$asequence = reverse @$asequence;
}

sub inout_octet_sequence ($$) {
    my($self,$asequence) = @_;
    $$asequence = reverse $$asequence;
}

sub inout_struct ($$) {
    my($self,$astruct) = @_;
    my $short = $astruct->{ashort};
    $astruct->{ashort} = length($astruct->{astring});
    $astruct->{astring} = $short;
}

sub inout_array ($$) {
    my($self,$anarray) = @_;
    @$anarray = reverse @$anarray;
}

sub out_long ($$) {
    my($self,$along) = @_;
    $$along = 28;
}

sub out_string ($$) {
    my($self,$astring) = @_;
    $$astring = 'Hi there';
}

sub out_long_sequence ($$) {
    my($self,$asequence) = @_;
    @$asequence = (-1,7,0);
}

sub out_octet_sequence ($$) {
    my($self,$asequence) = @_;
    $$asequence = 'nono';
}

sub out_struct ($$) {
    my($self,$astruct) = @_;
    $astruct->{ashort} = -34;
    $astruct->{astring} = 'thirtyfour';
}

sub out_array ($$) {
    my($self,$anarray) = @_;
    @$anarray = (-1,7,0,2);
}

sub ret_object ($) {
    my($self) = @_;
    return Test::Test2_skel->new;
}


1;
