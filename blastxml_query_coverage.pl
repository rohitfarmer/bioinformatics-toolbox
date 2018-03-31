#!/usr/bin/perl -w

=Synopsis
DESCRIPTION     : Parse BLAST XML output (downloaded from the NCBI BLAST website), 
                  to fetch sequences with a desired query coverage (percentage).
DEPENDENCIES    : XML::Simple
                  XML::Simple works by parsing an XML file and returning 
                  the data within it as a Perl hash reference. 
                  Within this hash, elements from the original XML file 
                  play the role of keys, and the CDATA between them takes 
                  the role of values. 
                  Once XML::Simple has processed an XML file, the content 
                  within the XML file can then be retrieved using standard 
                  Perl array notation.
                  more info www.techrepublic.com/article/parsing-xml-documents-with-perls-xmlsimple/5363190
USAGE           : blastxml.pl <file.xml> <query-coverage %>
INPUT           : file.xml
OUTPUT          : Prints fetched sequences in FASTA format on the standard output
                  in FASTA format which can be redirected to a file.
AUTHOR          : Rohit Farmer
EMAIL           : rohit.farmer@gmail.com
LAST MODIFIED   : 24/05/2012
=cut

use XML::Simple;
use strict;
use warnings;

# Create XML object
my $xml = new XML::Simple;

# Usage
if ($#ARGV < 1) {
    print STDERR "Usage: $0 <file.xml> <query coverage>\n";
    exit -1;
}

# Read data from the XML file
my $data = $xml->XMLin("$ARGV[0]");
my $querycov = $ARGV[1];


my $start_range=1; # defines the start range of the sequence
my $query_len = $data->{'BlastOutput_query-len'};

# Picks up the hits found and process it to select the highest scoring HSP (which is usually the first one).
foreach my $e(@{$data->{'BlastOutput_iterations'}->{'Iteration'}->{'Iteration_hits'}->{'Hit'}})
{
	# If a hit consist of multiple HSPs then the variable HSP will be an array reference rather than a hash reference. 
 	if(ref($e->{'Hit_hsps'}->{'Hsp'}) eq 'ARRAY')
 	{
 	  	my $hsp_hit_len =  $e->{'Hit_hsps'}->{'Hsp'}->[0]->{'Hsp_hit-to'} - $e->{'Hit_hsps'}->{'Hsp'}->[0]->{'Hsp_hit-from'} + 1;
 	  	my $hitpercent = ($hsp_hit_len/$query_len)*100;
 	  	if ($hitpercent >= $querycov)
		{
  			print ">",$e->{'Hit_id'}.$e->{'Hit_def'},"\n"; # Hit_id and Hit_def contains the gi id and the definition in the fasta tag.
  			print $e->{'Hit_hsps'}->{'Hsp'}->[0]->{'Hsp_hseq'},"\n"; # Hsp_hseq contains the subject sequence.
		}
 	}
 	# If a hit consist of only one HSP then the Hsp will be a hash rather than an array.
 	elsif(ref($e->{'Hit_hsps'}->{'Hsp'}) eq 'HASH')
 	{
  		my $hsp_hit_len = $e->{'Hit_hsps'}->{'Hsp'}->{'Hsp_hit-to'} - $e->{'Hit_hsps'}->{'Hsp'}->{'Hsp_hit-from'} + 1;
 	  	my $hitpercent = ($hsp_hit_len/$query_len)*100;
  		if ($hitpercent >= $querycov)
  		{
  			print ">",$e->{'Hit_id'}.$e->{'Hit_def'},"\n"; # Hit_id and Hit_def contains the gi id and the definition in the fasta tag.
			  print $e->{'Hit_hsps'}->{'Hsp'}->{'Hsp_hseq'},"\n"; # Hsp_hseq contains the subject sequence.
		}
 	}
}
