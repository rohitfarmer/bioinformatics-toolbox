#!/usr/bin/perl
#===============================================================================
#
#         FILE: filter_duplicate.pl
#
#        USAGE: ./filter_duplicate.pl  <file.fasta>
#
#  DESCRIPTION: This script is used to filter duplicate sequences from a file containing multiple fasta sequences.
#      OPTIONS: ---
# REQUIREMENTS: BioPerl
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Rohit Farmer 
#      COMPANY: University of Birmingham
#      VERSION: 1.0
#      CREATED: 03/23/2012 05:35:57 PM
#     REVISION: ---
#===============================================================================
use strict;
use warnings;
use Bio::SeqIO;

my %unique;

my $file   = $ARGV[0];
my $seqio  = Bio::SeqIO->new(-file => $file, -format => "fasta");
my $outseq = Bio::SeqIO->new(-file => ">$file.$ARGV[1].fasta", -format => "fasta");

while(my $seqs = $seqio->next_seq) {
  my $id  = $seqs->display_id;
  my $seq = $seqs->seq;
  if($seq=~m/$ARGV[1]/)
  {
  #unless(exists($unique{$seq})) {
   $outseq->write_seq($seqs);
    #$unique{$seq} +=1;
   
  }
}

