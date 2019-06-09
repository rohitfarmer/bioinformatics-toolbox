#!/usr/bin/perl 

# This script was used to convert the format of bond parameters from GAFF to Gromacs format (ffbonded.itp).
# The input required was a file containing the list of bond parameters from GAFF in Amber suite. 
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
    my $bondatom1=substr($_,0,2);
    my $bondatom2=substr($_,3,2);
    my $b0=substr($_,16,6);
    my $b0nm=sprintf("%6.5f",$b0/10);
    my $kb=substr($_,6,6);
    my $kbkj=sprintf("%8.1f",($kb*4.184*100*2));
    my $description=substr($_,29);
    print "  ",$bondatom1," ",$bondatom2,"         1    ",$b0nm,"   ",$kbkj, " ; $description\n";
}

close(FILE);
