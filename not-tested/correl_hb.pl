#!/usr/bin/perl -w

#This script was used to calculate the correlation between the cavity volume and the hydrogen bonds formed with the protein over time.
#It requires two input files the first one is the cavity volume file and the second is the hydrogen bonds file.

use strict;
use Math::NumberCruncher;

open(VOLUME, $ARGV[0]) || die "Can't open volume file";
open(HB, $ARGV[1]) || die "Can't open hydrogen bond file";

my @time=();
my @volume=();
my @hbond=();
my %HBond=();
my $i=-1;
while (<VOLUME>)
{
 if($_ =~m/(\d+.\d+)\s+(\d+.\d+)/)
 {
  if($2!=0)
  { 
  $i++;
   chomp($1);
   chomp($2);
   $time[$i]=$1;
   $volume[$i]=$2; 
  }
 }
}
close VOLUME;

while (<HB>)
{
 if($_=~m/^\s+(\d+)\s+(\d+)\s+(\d+)/)
 {
  chomp($1);
  chomp($2);
  my $k=$1.".000";
  $HBond{"$k"}="$2";
 }
}
close HB;

foreach (@time)
{
  push (@hbond, $HBond{"$_"});
}

for(my $i=0;$i<= $#time;$i++)
{
 print $time[$i],",",$volume[$i],",",$hbond[$i],"\n";
}

print "Correlation using NumberCruncher = ", Math::NumberCruncher::Correlation(\@volume, \@hbond),"\n";
