#!/usr/bin/perl 

use strict;
use warnings;
use Bio::SeqIO;

# This script is used to check for catalytic S at the aligned position in a MSA file

my $in  = Bio::SeqIO->new(-file => "rerun_refseq_trembl_amalgamated_unique_aligned.fasta" , '-format' => 'Fasta');
my $count =0;
open(my $out, ">rerun_refseq_trembl_amalgamated_filtered_S.fasta");

while ( my $seq = $in->next_seq() ) 
{
 my $s = $seq->subseq(361,361);
  if($s eq 'S')
   {
    print $out ">".$seq->id,"\n";
    print $out $seq->seq(),"\n";
    $count++;
   }
}
print $count;
