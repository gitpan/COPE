#!/opt/perl/bin/perl -w
#
# $Id: testserver.pl,v 1.1.1.1 1997/05/17 11:47:05 schuller Exp $
# Copyright (c) 1997 Lunatech Research / Bart Schuller <schuller@lunatech.com>
# See the file "Artistic" in the distribution for licensing and
# (lack of) warranties.

use Carp;

use strict;
use COPE::CORBA::ORB;
use COPE::Test_skel;
$|=1;

my $orb = CORBA::ORB_init();
my $boa = $orb->BOA_init();

my $test_skel = new Test::Test1_skel;
my $testref = $orb->object_to_string($test_skel);
print "$testref\n";

$boa->impl_is_ready();
