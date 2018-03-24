#!/usr/bin/perl

=Synopsis
DESCRIPTION     : Filters duplicate sequences from a multiple FASTA file.
DEPENDENCIES    : BioPerl
USAGE           : filter_duplicate.pl <file.fasta>
INPUT           : file.fasta
OUTPUT          : Generates new file with the extension <file.unique.fasta>
AUTHOR          : Dr. Rohit Farmer
EMAIL           : rohit.farmer@gmail.com
LAST MODIFIED   : 24/05/2016
=cut

use strict;
use warnings;
use Bio::SeqIO;

# Usage check
if (   $#ARGV < 0
	or $ARGV[0] eq 'help'
	or $ARGV[0] eq 'h' )
{
	print "Usage: filter_duplicate.pl file.fasta\n";
	exit -1;
}

# BioPerl object creation
my %unique;
my $file = $ARGV[0];
my $seqio = Bio::SeqIO->new( -file => $file, -format => "fasta" );
my $outseq = Bio::SeqIO->new( -file => ">$file.unique.fasta", -format => "fasta" );

# Filter duplicate sequences and generate the output file
while ( my $seqs = $seqio->next_seq ) {
	my $id  = $seqs->display_id;
	my $seq = $seqs->seq;
	unless ( exists( $unique{$seq} ) ) {
		$outseq->write_seq($seqs);
		$unique{$seq} += 1;
	}
}

