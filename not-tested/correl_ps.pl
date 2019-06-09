#!/usr/bin/perl -w

#This script was used to calculate the correlation between the hydrogen bonds formed with the protein and the ligand as compared to the hydrogen bonds formed between the solvent and the ligand over time.
#It requires two input files the first one is the hydrogen bonds with the protein and the other with the solvent.

use strict;
use Math::NumberCruncher;

open(PROTEIN, $ARGV[0]) || die "Can't open file";
open(SOLVENT, $ARGV[1]) || die "Can't open file";

my @hbprotein=();
my @hbsolvent=();

my $i=-1;

while (<PROTEIN>)
{
 if($_=~m/^\s+(\d+)\s+(\d+)\s+(\d+)/)
 {
   $i++;
   chomp($2);
   $hbprotein[$i]=$2; 
  
 }
}
close PROTEIN;

$i=-1;
while (<SOLVENT>)
{
 if($_=~m/^\s+(\d+)\s+(\d+)\s+(\d+)/)
 {
   $i++;
   chomp($2);
   $hbsolvent[$i]=$2; 
 }
}
close SOLVENT;

for(my $i=0;$i<= $#hbprotein; $i++)
{
 print $hbprotein[$i],",",$hbsolvent[$i],"\n";
}

print "Correlation using NumberCruncher = ", Math::NumberCruncher::Correlation(\@hbprotein, \@hbsolvent),"\n";
