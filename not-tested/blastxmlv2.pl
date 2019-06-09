#!/usr/bin/perl -w

# This script is used to parse the BLAST XML output, using XML::Simple module.
# XML::Simple works by parsing an XML file and returning the data within it as a Perl hash reference. 
# Within this hash, elements from the original XML file play the role of keys, and the CDATA between them takes the role of values. 
# Once XML::Simple has processed an XML file, the content within the XML file can then be retrieved using standard Perl array notation.
# more info www.techrepublic.com/article/parsing-xml-documents-with-perls-xmlsimple/5363190


 
## use module
use XML::Simple;
use strict;
use warnings;
# use Data::Dumper; # this module is to print and view the hash/array structure fetched from the XML file

## create object
my $xml = new XML::Simple;

## read XML file from command line
if ($#ARGV < 1) {
    print STDERR "Usage: $0 <file.xml> <query coverage>\n";
    exit -1;
}

my $data = $xml->XMLin("$ARGV[0]");
my $querycov = $ARGV[1];

#print Dumper($data); # this is to print the structure of the hash and array fetched from the XML file

## Define variables
# for the length of the query sequence 
#my $query_len=656; # defines the end range of the sequence so anything above this position
my $start_range=1; # defines the start range of the sequence so anything below this position
my $query_len = $data->{'BlastOutput_query-len'};

# this foreach loop picks up the hits found and process it to select the highest scoring HSP (which is usually the first one)

foreach my $e(@{$data->{'BlastOutput_iterations'}->{'Iteration'}->{'Iteration_hits'}->{'Hit'}})
{
	# if a hit consist of multiple Hsps then the variable Hsp will be an array reference rather than a hash reference 
 	if(ref($e->{'Hit_hsps'}->{'Hsp'}) eq 'ARRAY')
 	{
 	  	my $hsp_hit_len =  $e->{'Hit_hsps'}->{'Hsp'}->[0]->{'Hsp_hit-to'} - $e->{'Hit_hsps'}->{'Hsp'}->[0]->{'Hsp_hit-from'} + 1;
 	  	my $hitpercent = ($hsp_hit_len/$query_len)*100;
 	  	#if ($e->{'Hit_hsps'}->{'Hsp'}->[0]->{'Hsp_align-len'} >=1000) # Hsp_align-len is to get the resutl according to the alignment length rather than the query sequence length 
 	  	#if ($e->{'Hit_hsps'}->{'Hsp'}->[0]->{'Hsp_query-from'} <= $start_range && $e->{'Hit_hsps'}->{'Hsp'}->[0]->{'Hsp_query-to'} >= $query_len) # Hsp_query-from and Hsp_query-to carry the starting and ending index of the query sequence length
 	  	if ($hitpercent >= $querycov)
		{
  			print ">",$e->{'Hit_id'}.$e->{'Hit_def'},"\n"; # Hit_id and Hit_def contains the gi id and the definition in the fasta tag
  			print $e->{'Hit_hsps'}->{'Hsp'}->[0]->{'Hsp_hseq'},"\n"; # Hsp_hseq contains the subject sequence
		}
 	}
 	# if a hit consist of only one HSP then the Hsp will be a hash rather than an array
 	#elsif ($e->{'Hit_hsps'}->{'Hsp'}->{'Hsp_align-len'} >=1000) # Hsp_align-len is to get the resutl according to the alignment length rather than the query sequence length
 	#elsif ($e->{'Hit_hsps'}->{'Hsp'}->{'Hsp_query-from'} <= $start_range && $e->{'Hit_hsps'}->{'Hsp'}->{'Hsp_query-to'} >= $query_len) 
 	elsif(ref($e->{'Hit_hsps'}->{'Hsp'}) eq 'HASH')
 	{
  		my $hsp_hit_len = $e->{'Hit_hsps'}->{'Hsp'}->{'Hsp_hit-to'} - $e->{'Hit_hsps'}->{'Hsp'}->{'Hsp_hit-from'} + 1;
 	  	my $hitpercent = ($hsp_hit_len/$query_len)*100;
  		if ($hitpercent >= $querycov)
  		{
  			print ">",$e->{'Hit_id'}.$e->{'Hit_def'},"\n"; # Hit_id and Hit_def contains the gi id and the definition in the fasta tag
			print $e->{'Hit_hsps'}->{'Hsp'}->{'Hsp_hseq'},"\n"; # Hsp_hseq contains the subject sequence
		}
 	}
}
