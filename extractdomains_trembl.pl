#!/usr/bin/perl

=Synopsis
DESCRIPTION     : Reads hmmsearch output from HMMER software and extracts matched sequences in FASTA format.
DEPENDENCIES    : hmmsearch must be done against trembl database.
USAGE           : extractdomains_trembl.pl <hmmsearch output file>
INPUT           : hmmsearch output file
OUTPUT          : Prints sequences in FASTA format.
AUTHOR          : Dr. Rohit Farmer
EMAIL           : rohit.farmer@gmail.com
=cut

use warnings;
use strict;
use Data::Dumper;

my @fastatag;
my @sequence;
my @winnDomains;
my @len;
my $winnDomain;

while( <> ) {
	my $fa = undef;
	my $seq = undef;
	$winnDomain = $1 if /\=\= domain\s(\d+)/;  # Search for the line which starts with ==domain num and read the number of the domain
	if( m/^\s+(tr\|[\w\|\_\-\.]+|sp\|[\w\|\_\-\.]+)\s+\d+.([A-Za-z_\-]+)/ ) {
		$fa = $1;#Store the name or tag 
		$seq = $2;#Sotre the sequence
	}

	# Push everything catched above in an array
	if( $fa && $seq ) {
		$seq =~ s/\-//g;
		push @winnDomains, $winnDomain;
		push @fastatag, $fa;
		push @sequence, $seq;
		push @len, length( $seq );
	}
}

# Sort all the sequences according to lenght in decreasing order
my @sorted = sort { $len[$b] <=> $len[$a] } 0 .. $#len;

#print Dumper @fastatag; # This is to crosscheck

# Output the final list
for my $i ( @sorted ) {
	if(length($sequence[$i])>=60)
	{
	print '>'. $fastatag[$i] . "|Domain_" . $winnDomains[$i] . "\n";
	print $sequence[$i] . "\n\n\n";
	}
	else{ last;}
}

print "Number of sequences in sorted array: ",scalar @sorted;

