#!/usr/bin/perl -w

use strict;

#This script was used to generate single point mutation in a sequence with all the other 19 amino acids.
#The highest scoring sequence from the previous generation.
my td3a=split(//,"SVICEALSDALKVPKKMIDPTEAFSDYGLDSITGVNV
	          AQTISSVLNVDLKTTALFDYVCIDQLARYV"); 

my @amino=split(//,"ARNDCEQGHILKMFPSTWYV"); #Read the 20 amino acids
my $i;
my $j;
my @temp;
my $count=0;

for($i=0; $i<=$#td3a; $i++) #Iterate every position in the original sequence
{
@temp=@td3a;
 for($j=0;$j<=$#amino;$j++) #Iterate every amino acid in the array
 {
  if($td3a[$i] ne $amino[$j]) #Check if the amino acid is in the position or not if not then replace it with the amino acids from the amino acid array
  {
  $count++;
  $temp[$i]=$amino[$j]; 
  print ">$count\n";
  print @temp,"\n";
  }
 }
undef @temp;
}
