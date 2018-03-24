#!/usr/bin/perl 

=Synopsis
DESCRIPTION     : Calculate the length of the sequence(s) in FASTA format.
DEPENDENCIES    : none
USAGE           : length.pl <file.fasta>
INPUT           : file.fasta
OUTPUT          : Prints length of standard output
AUTHOR          : Dr. Rohit Farmer
EMAIL           : rohit.farmer@gmail.com
LAST MODIFIED   : 24/05/2016
=cut

use strict;
use warnings;

# Usage check
if (   $#ARGV < 0
	or $ARGV[0] eq 'help'
	or $ARGV[0] eq 'h' )
{
	print "Usage: length.pl input.fasta\n";
	exit -1;
}

# Open file
open( FILE, "$ARGV[0]" ) || die "Can't open file";

# Concatenate sequences in a single string
my $count;
my $seq = "";
my $tag = "";
my %seqs;

while (<FILE>) {
	if ( $_ =~ m/^>/ ) {
		$tag = $_;
		$seq = "";
	}
	else {
		$_ =~ s/\s+//g;
		$_ =~ s/\n//g;
		$_ =~ s/-//g;
		$_ =~ s/\d+//g;
		$seq .= $_;
	}

	$seqs{$tag} = $seq;
}

# Print the output
while ( ( my $key, my $value ) = each(%seqs) ) {
	print $key, length($value), "\n";
}