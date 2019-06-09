#!/usr/bin/perl 

# This script was used to convert the format of atom name and mass from GAFF to Gromacs format (atomtypes.atp).
# The input required was a file containing the list of atoms with mass from GAFF in Amber suite. 
use strict;
use warnings;

if ($#ARGV < 0) {
    print STDERR "Usage: $0 <file.txt>\n";
    exit -1;
}

open(FILE, "$ARGV[0]") || die "Can't open file";

while(<FILE>)
{
    chomp($_);
    my $atomname=substr($_,0,2);
    my $atommass=substr($_,3,5);
    my $atommassfloat=sprintf("%9.5f",$atommass);
    my $description=substr($_,36);
    print $atomname,"               ",$atommassfloat,"      ;",$description, "\n";
}

close(FILE);
