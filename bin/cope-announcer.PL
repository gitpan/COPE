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
# $Id: cope-announcer.PL,v 1.2 1997/06/19 14:34:38 schuller Exp $
# Copyright (c) 1997 Lunatech Research / Bart Schuller <schuller@lunatech.com>
# See the file "Artistic" in the distribution for licensing and
# (lack of) warranties.

use strict;
use COPE::Announcer;

COPE::Announcer::daemon();

__END__

=head1 NAME

cope-announcer - Bootstrapping daemon for CORBA services

=head1 SYNOPSIS

    cope-announcer

=head1 DESCRIPTION

This program listens for messages on UDP port 3228. Clients requesting the
IOR of a service can do so by broadcasting a message, which will be picked
up and answered by this daemon.

See L<cope-ns> for an example and L<COPE::Announcer> for more information.

!NO!SUBS!
