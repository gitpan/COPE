use Config;
use File::Basename qw(basename dirname);
chdir(dirname($0));
($file = basename($0)) =~ s/\.PL$//;
$file =~ s/\.pl$//
        if ($Config{'osname'} eq 'VMS' or
            $Config{'osname'} eq 'OS2');  # "case-forgiving"
open OUT,">$file" or die "Can't create $file: $!";
chmod(0755, $file);
print "Extracting $file (with variable substitutions)\n";

print OUT <<"!GROK!THIS!";
$Config{'startperl'} -w
    eval 'exec perl -S \$0 "\$@"'
        if 0;

!GROK!THIS!

print OUT <<'!NO!SUBS!';
#
# $Id: cope-ns.PL,v 1.4 1997/06/19 14:34:38 schuller Exp $
# Copyright (c) 1997 Lunatech Research / Bart Schuller <schuller@lunatech.com>
# See the file "Artistic" in the distribution for licensing and
# (lack of) warranties.

use Carp;
BEGIN { $SIG{__WARN__} = $SIG{__DIE__} = sub { confess @_ } }

use strict;
use Getopt::Long;
use COPE::CORBA::ORB;
use COPE::CosNaming_skel;
use COPE::Announcer;

my %options;

$options{ior} = 0;
GetOptions( \%options, 'ior!');
my $orb = CORBA::ORB_init();
my $boa = $orb->BOA_init();

my $naming_skel = new CosNaming::NamingContext_skel;
my $namingref = $orb->object_to_string($naming_skel);
if ($options{ior}) {
    local $| = 1;
    print "$namingref\n";
} elsif (!COPE::Announcer::announce('NameService', $namingref)) {
    print STDERR "$0: Warning: couldn't register with cope-announce\n";
}

$boa->impl_is_ready();

__END__

=head1 NAME

cope-ns - CORBA NameService implementation in Perl

=head1 SYNOPSIS

    cope-ns [--ior]

=head1 DESCRIPTION

See the CosNaming documentation for details.

=head1 NOTES

C<cope-ns> tries to register itself with an instance of C<cope-announcer>
(see L<cope-announcer>) running on the local network. If you don't have
an announcer running, you might experience a 10 second delay on start-up.

!NO!SUBS!
