#!/usr/bin/perl

=Synopsis
DESCRIPTION     : Calculates the RMSD between a reference structure and a structure extracted from a file containing multiple PDB (generated using VMD).
DEPENDENCIES    : mattopenmp (Matt alignment software)
                  Multiple PDB file should be generated via VMD software.
USAGE           : rmsd_matt.pl <reference-structure.pdb> <multi.pdb>
INPUT           : reference-structure.pdb multi.pdb
OUTPUT          : Generates following files: MattAlignment.fasta MattAlignment.pdb MattAlignment.spt MattAlignment.txt protein2.pdb RMSD.txt
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
	print "Usage: rmsd_matt.pl reference-structure.pdb multi.pdb\n";
	exit -1;
}

# Read reference and multi PDB file
my $protein1    = $ARGV[0];    
my $multiplepdb = $ARGV[1];    
open( PDB,  "<$multiplepdb" ) or die "Can not open file";
open( OUT,  ">protein2.pdb" ) or die "Can not create file";
open( RMSD, ">RMSD.txt" )     or die "Can not create file";

# Run mattopenmp, calculate RMSD and generate output files
my $i = 0;
while (<PDB>) {

	if ( $_ =~ m/^ATOM/ ) {

		#print $_;
		print OUT $_;
		next;
	}
	elsif ( $_ =~ m/^END/ ) {
		system("mattopenmp -t 4 $protein1 protein2.pdb -o MattAlignment");
		open( MattOutput, "<MattAlignment.txt" );
		while (<MattOutput>) {
			if ( $_ =~ m/^Core RMSD:\s(\d+.\d+)/ ) {
				print RMSD "$i,$1\n";
			}
		}
		system("rm protein2.pdb");
		open( OUT, ">protein2.pdb" ) or die "Can not create file";
		$i++;
	}
}