#!/usr/bin/perl 

# This script was used to convert the format of bond angle parameters from GAFF to Gromacs format (ffbonded.itp).
# The input required was a file containing the list of bond angle parameters from GAFF in Amber suite. 
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
    my $angleatom1=substr($_,0,2);
    my $angleatom2=substr($_,3,2);
    my $angleatom3=substr($_,6,2);
    my $th0=substr($_,22,7);
    my $cth=substr($_,10,6);
    my $cthkj=sprintf("%8.3f",($cth*4.184*2));
    my $description=substr($_,30);
    print $angleatom1,"  ",$angleatom2,"  ",$angleatom3,"           1   ",$th0,"   ",$cthkj," ; $description\n";
}

close(FILE);
