# $Id: Makefile.PL,v 1.6 1997/07/25 10:12:31 schuller Exp $
# Copyright (c) 1997 Lunatech Research / Bart Schuller <schuller@lunatech.com>
# See the file "Artistic" in the distribution for licensing and
# (lack of) warranties

my @programs_to_install = qw(idl2perl cope-ns cope-announcer);

use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'	=> 'COPE',
    'VERSION' => 0.04,
    'PL_FILES'  => { map {("bin/$_.PL" => "bin/$_")} @programs_to_install },
    'EXE_FILES' => [ map {"bin/$_"} @programs_to_install ],
    'clean'     => { FILES => '$(EXE_FILES)' },
    'dist'  => {'COMPRESS' => 'gzip -9f', 'SUFFIX' => 'gz',},
    'LIBS'	=> [''],   # e.g., '-lm' 
    'DEFINE'	=> '',     # e.g., '-DHAVE_SOMETHING' 
    'INC'	=> '',     # e.g., '-I/usr/include/other' 
);
