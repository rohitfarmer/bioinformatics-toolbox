#!/usr/bin/perl -w

#This script was used to fetch the distance values from g_dist output file and calculate the average of the three distances.
#It requires three input files, the output will be displayed on the screen.

use strict;

open(DIST1, $ARGV[0]) || die "Can't open first distance file";
open(DIST2, $ARGV[1]) || die "Can't open second distance file";
open(DIST3, $ARGV[2]) || die "Can't open third distance file";

my @time=();
my @dist1=();
my @dist2=();
my @dist3=();
my $average=0;

my $i=-1;
while (<DIST1>)
{
 if($_=~m/^@|#/)
 {next} 
 elsif($_ =~m/(\d+.\d+)\s+(\d+.\d+)\s+(-?\d+.\d+)\s+(-?\d+.\d+)\s+(-?\d+.\d+)/)
 {
   $i++;
   chomp($1);
   chomp($2);
   $time[$i]=$1;
   $dist1[$i]=$2; 
 }

}
close DIST1;
$i=-1;
while (<DIST2>)
{
 if($_=~m/^@|#/)
 {next} 
 elsif($_ =~m/(\d+.\d+)\s+(\d+.\d+)\s+(-?\d+.\d+)\s+(-?\d+.\d+)\s+(-?\d+.\d+)/)
 {
   $i++;
   chomp($2);
   $dist2[$i]=$2; 
 }
}
close DIST2;

$i=-1;
while (<DIST3>)
{
 if($_=~m/^@|#/)
 {next} 
 elsif($_ =~m/(\d+.\d+)\s+(\d+.\d+)\s+(-?\d+.\d+)\s+(-?\d+.\d+)\s+(-?\d+.\d+)/)
 {
   $i++;
   chomp($2);
   $dist3[$i]=$2; 
 }
}
close DIST3;

# print '@    title "Distance"
# @    xaxis  label "Time (ns)"
# @    yaxis  label "Distance (nm)"',"\n";
for(my $j=0; $j<=$#dist1 ;$j++)
{
	$average=($dist1[$j]+$dist2[$j]+$dist3[$j])/3;
	if($average!=0)
	{
	my $averageRounded = sprintf("%.3f", $average);
	my $timeInNanoSecond= $time[$j]/1000;
	print $timeInNanoSecond,"\t",$averageRounded,"\n";
	}
}
