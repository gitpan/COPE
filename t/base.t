#!/opt/perl/bin/perl -w
#
# $Id: base.t,v 1.2 1997/07/31 11:04:00 schuller Exp $
# Copyright (c) 1997 Lunatech Research / Bart Schuller <schuller@lunatech.com>
# See the file "Artistic" in the distribution for licensing and
# (lack of) warranties.

use Carp;
use strict;

use lib 't';
use COPE::CORBA::ORB;
use COPE::Test;
use COPE::CORBA::Exception;
use IO::Handle;
use Config;

$| = 1;

my $orb = CORBA::ORB_init();

my $includes = join(' ', map {"-I$_"} @INC);
my $serverfh = new IO::Handle;
my $pid = open($serverfh, '-|');
if (!$pid) {
    exec "$Config{perlpath} $includes t/testserver.pl";
    die "exec failed: $!";
}
my $testref = <$serverfh>;
chomp $testref;
END {
    kill 'TERM', $pid;
    $serverfh->close;
    exit 0;
}
my $obj = $orb->string_to_object($testref);
my $test = Test::Test1->_narrow($obj);

my $testnum = 1;
sub test ($) {
    my($condition) = @_;
    if (!$condition) {
        print "not ";
    }
    print "ok ", $testnum++, "\n";
}

BEGIN { print "1..26\n" }

test($test->in_long(5) == -5);
test($test->in_string('Perl') eq 'lreP');
test(join('',@{$test->in_long_sequence([0,2,4,5])}) eq '5420');
test($test->in_octet_sequence('qwerty') eq 'ytrewq');
my $struct = $test->in_struct(new Test::TestStruct
                                    astring => 'Hello', ashort => -4);
test(($struct->{astring} eq '-4') && ($struct->{ashort} == 5));
test(join('',@{$test->in_array([0,2,4,5])}) eq '5420');

# 7
my $var = -5;
$test->inout_long(\$var);
test($var == 5);
$var = '123';
$test->inout_string(\$var);
test($var eq '321');
$var = [-18000,2,5];
$test->inout_long_sequence($var);
test(join('',@$var) eq '52-18000');
$var = 'aaah';
$test->inout_octet_sequence(\$var);
test($var eq 'haaa');
$struct = new Test::TestStruct astring => 'yow', ashort => 32767;
$test->inout_struct($struct);
test(($struct->{astring} eq '32767') && ($struct->{ashort} == 3));
$var = [-18000,2,5,0];
$test->inout_array($var);
test(join('',@$var) eq '052-18000');

# 13
$test->out_long(\$var);
test($var == 28);
$test->out_string(\$var);
test($var eq 'Hi there');
$var = [];
$test->out_long_sequence($var);
test(join('',@$var) eq '-170');
$test->out_octet_sequence(\$var);
test($var eq 'nono');
$test->out_struct($struct);
test(($struct->{astring} eq 'thirtyfour') && ($struct->{ashort} == -34));
$var = [];
$test->out_array($var);
test(join('',@$var) eq '-1702');

# 19
my $test2 = $test->ret_object();
test(defined $test2);
test($test2->check() eq 'ok');
try {
    $test2->etest();
} catch 'Test::Test2::AnException' => sub {
    test($_[0]->{why} eq 'because');
    test($_[0]->{minor} == 1);
};
$test2->anattr('olah');
test($test2->anattr() eq 'olah');
test($test2->count() == 15);
test($Test::Test2::NAME eq 'Bart');
test($Test::Test2::AGE == 28);
# my $brother = $test->ret_object();
# my $counter = 4;
# $test2->help_brother(\$counter, $brother);
# test($counter == 0);
