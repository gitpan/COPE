#!/opt/perl/bin/perl -w
#
# $Id: naming.t,v 1.6 1997/07/31 11:04:00 schuller Exp $
# Copyright (c) 1997 Lunatech Research / Bart Schuller <schuller@lunatech.com>
# See the file "Artistic" in the distribution for licensing and
# (lack of) warranties.

use Carp;
BEGIN { $SIG{__WARN__} = $SIG{__DIE__} = sub { confess @_ } }

use strict;

use lib 't';
use COPE::CORBA::ORB;
use COPE::CosNaming;
use COPE::LName;
use COPE::CORBA::Exception;
use IO::Handle;
use Config;

$| = 1;

my $orb = CORBA::ORB_init();

my $includes = join(' ', map {"-I$_"} @INC);
my $nameserver = "$Config{perlpath} $includes bin/cope-ns --ior";
# my $nameserver = "nsserv --ior";
my $serverfh = new IO::Handle;
my $pid = open($serverfh, '-|');
if (!$pid) {
    exec $nameserver;
    die "exec failed: $!";
}
my $nsref = <$serverfh>;
chomp $nsref;
END {
    kill 'TERM', $pid;
    $serverfh->close;
    exit 0;
}
my $obj = $orb->string_to_object($nsref);
my $ns = CosNaming::NamingContext->_narrow($obj);

my $testnum = 1;
sub test ($) {
    my($condition) = @_;
    if (!$condition) {
        print "not ";
    }
    print "ok ", $testnum++, "\n";
}

BEGIN { print "1..6\n" }

my $name = [ CosNaming::NameComponent->new('id' => 'lunatech.com', 'kind' => '') ];
my $lnc = new LNameComponent;
$lnc->id('lunatech.com');
$lnc->kind('');
my $ln = new LName;
$ln->insert_component(1, $lnc);
my $ln2 = LName->new;
$ln2->from_idl_form($name);
# 1
test($ln->equal($ln2));
my $ctx = $ns->bind_new_context($name);
# 2
test($ctx);
my $bindinglist = [];
my $iterator;
$ns->list(4, $bindinglist, \$iterator);
# 3
test($bindinglist->[0]{binding_name}[0]{id} eq 'lunatech.com');
$ln = new LName;
$ln->insert_component(1, $lnc);
$lnc->id('NamingService');
$ln->insert_component(2, $lnc);
$name = $ln->to_idl_form;
# 4
test($name->[0]{id} eq 'lunatech.com');
$ns->bind($name, $ns);
$ctx->list(4, $bindinglist, \$iterator);
# 5
test($bindinglist->[0]{binding_name}[0]{id} eq 'NamingService');
my $ns2;
try {
    $ns2 = $ctx->resolve([$lnc]);
} catch 'CosNaming::NamingContext::NotFound' => sub {
    print "why => $_[0]->{why}\n";
    print "rest_of_name => $_[0]->{rest_of_name}[0]{id}\n";
};
# 6
test($ns2);
