#!/usr/bin/perl -w

use strict;

open(FILE, $ARGV[0]) || die "Can't open file";

my $pos = $ARGV[1];
my $residue = $ARGV[2];
my $lcresidue = lc($residue);
my $ucresidue = uc($residue);

my $seq;
my $tag;
my @arr;
my %tag_seq;
my %useful;
while(<FILE>)
{
  if($_ =~ m/^\>(.+)/ ) # Match for the fasta tag line and store it in @arr
    {
    	$tag = $1;
    	push @arr,$1;
    	$tag_seq{$tag}= "";
    }
  else
    {
     	$seq=$_;
     	chomp($seq);
     	$tag_seq{$tag}.=$seq; # Store the sequence in the has %tag_seq
    }
   
}

foreach(@arr)
{
  my @s= split(//,$tag_seq{$_});
  if ($s[$pos-1] eq "$lcresidue" || $s[$pos-1] eq $ucresidue)
  {
  	print ">$_\n",@s,"\n";
  }
  
}
