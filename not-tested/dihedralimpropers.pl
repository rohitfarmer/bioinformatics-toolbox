#!/usr/bin/perl 

# This script was used to convert the format of improper angle parameters from GAFF to Gromacs format (ffbonded.itp).
# The input required was a file containing the list of improper angle parameters from GAFF in Amber suite. 
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
    my $dihedralatom1=substr($_,0,2);
    my $dihedralatom2=substr($_,3,2);
    my $dihedralatom3=substr($_,6,2);
    my $dihedralatom4=substr($_,9,2);
    #my $IDIVF=substr($_,14,1);
    my $PK=substr($_,20,4);
    my $kth=sprintf("%8.5f",($PK*4.184));
    my $phase=sprintf("%5.2f",substr($_,33,4));
    my $PN=substr($_,47,1);
    my $description=substr($_,60);
    print $dihedralatom1,"  ",$dihedralatom2,"  ",$dihedralatom3,"  ",$dihedralatom4,"       4      ",$phase,"    ",$kth,"     ",$PN,"    ; ",$description,"\n";
}

close(FILE);
