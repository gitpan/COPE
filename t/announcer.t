#!/opt/perl/bin/perl -w
#
# $Id: announcer.t,v 1.2 1997/06/19 14:34:40 schuller Exp $
# Copyright (c) 1997 Lunatech Research / Bart Schuller <schuller@lunatech.com>
# See the file "Artistic" in the distribution for licensing and
# (lack of) warranties.

use strict;

use lib 't';
use COPE::Announcer;
use Config;

$| = 1;

my $orb = CORBA::ORB_init();

my $includes = join(' ', map {"-I$_"} @INC);
my $announcer = "$Config{perlpath} $includes bin/cope-announcer";
my $pid = fork;
if (!$pid) {
    exec $announcer;
    die "exec failed: $!";
}
END {
    kill 'TERM', $pid;
    exit 0;
}

my $testnum = 1;
sub test ($) {
    my($condition) = @_;
    if (!$condition) {
        print "not ";
    }
    print "ok ", $testnum++, "\n";
}

BEGIN { print "1..2\n" }

test(COPE::Announcer::announce('test', 'correct') eq 'ADDED');
test(COPE::Announcer::resolve('test') eq 'correct');
