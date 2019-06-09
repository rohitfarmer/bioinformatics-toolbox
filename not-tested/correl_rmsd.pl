#!/usr/bin/perl -w

#This script was used to calculate the correlation between the cavity volume and the RMSD over time.
#It requires two input files the first one is the cavity volume file and second the RMSD file.

use strict;
use Math::NumberCruncher;

open(VOLUME, $ARGV[0]) || die "Can't open volume file";
open(RMSD, $ARGV[1]) || die "Can't open RMSD file";

my @time=();
my @rmsd=();
my @vol=();
my %volume=();
my $i=-1;

while (<VOLUME>)
{
 if($_ =~m/(\d+.\d+)\s+(\d+.\d+)/)
 {
   chomp($1);
   chomp($2);
   $volume{$1}=$2;
   
  }
}

close VOLUME;

while(<RMSD>)
{
 if($_=~m/(\d+),(\d+.\d+)/)
 {
  $i++;
   chomp($1);
   chomp($2);
   $time[$i]=($1*1000).".000";
   $rmsd[$i]=$2;
 }
}
close RMSD;

foreach (@time)
{
  push (@vol, $volume{"$_"});
}

for(my $i=0;$i<= $#time;$i++)
{
 print $time[$i],",",$vol[$i],",",$rmsd[$i],"\n";
}

print "Correlation using NumberCruncher = ", Math::NumberCruncher::Correlation(\@vol, \@rmsd),"\n";
