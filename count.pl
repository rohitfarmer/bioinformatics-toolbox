#!/usr/bin/perl 

=Synopsis
DESCRIPTION     : Counts the number of sequences in a multiple FASTA file.
DEPENDENCIES    : none
USAGE           : count.pl <name.fasta>
INPUT           : name.fasta
OUTPUT          : Number of FASTA sequences: <number>
AUTHOR          : Dr. Rohit Farmer
EMAIL           : rohit.farmer@gmail.com
LAST MODIFIED   : 24/02/2018
=cut

use strict;
use warnings;

# Usage check
if (   $#ARGV < 0
	or $ARGV[0] eq 'help'
	or $ARGV[0] eq 'h' )
{
	print "Usage: count.pl input.fasta\n";
	exit -1;
}

# Open file
open( FILE, "$ARGV[0]" ) || die "Can't open file";

# Count the number of FASTA sequences
my $count;
while (<FILE>) {
	if ( $_ =~ m/^>/ ) {
		$count++;
	}
}

# Output
print "Number of FASTA sequences in $ARGV[0]: $count\n";
close(FILE);
