#!/usr/bin/perl 
#===============================================================================
#
#         FILE: fasta_to_uniprot.pl
#
#        USAGE: ./fasta_to_uniprot.pl  <file.fasta>
#
#  DESCRIPTION: This script is used to convert the fasta tag line into a random uniprot
#  				style ID followed by a / and length range for co-evolution script.
#
#      OPTIONS: ---
# REQUIREMENTS: BioPerl module 
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Rohit Farmer
#      COMPANY: University of Birmingham
#      VERSION: 1.0
#      CREATED: 02/18/2013 11:48:26 AM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use Bio::SeqIO;

my $file   = $ARGV[0];

if ($#ARGV < 0) {
    print STDERR "Usage: $0 <file.fasta>\n";
	    exit -1;
		}

my $seqio  = Bio::SeqIO->new(-file => $file, -format => "fasta");
open(MAP, ">$ARGV[0].map") or die "Can't create the map file";
open(OUTPUT, ">$ARGV[0].uniprot") or die "Can't create the output file";

while(my $seqs = $seqio->next_seq) {
  my $id  = $seqs->display_id;
  my $seq = $seqs->seq;
  my $sequence = $seq;
  $seq =~ s/-//g;
  my $uni_id1="";
  my $uni_id2="";
  my @chars = ("A".."Z");
  $uni_id1.= $chars[rand @chars] for 1..5;
  $uni_id2.= $chars[rand @chars] for 1..5;
  my $uni_id=">".$uni_id1."_".$uni_id2."\/"."1-".length($seq)."\n";
  print OUTPUT $uni_id, $sequence,"\n";
  print MAP $id."\=\=".$uni_id;
}
	  
close(MAP);
close(OUTPUT);
