#!/usr/bin/perl 

=Synopsis
DESCRIPTION     : Converts the ATOM flag to HETATM flag for the ligand residue in the HADDOCK output file.
DEPENDENCIES    : none
USAGE           : atom2hetatm.pl <file.pdb> <residue name>
INPUT           : file.pdb & residue name
OUTPUT          : Prints the modified file in the PDB format on the standard output.
AUTHOR          : Dr. Rohit Farmer
EMAIL           : rohit.farmer@gmail.com
LAST MODIFIED   : 28/01/2014
=cut

use strict;
use warnings;

# Check usage
if ($#ARGV < 1) {
    print STDERR "Usage: atom2hetatm.pl <file.pdb> <residue name>\n";
    exit -1;
}

# Open HADDOCK file
open(FILE, "$ARGV[0]") || die "Can't open file";

# Search and replace ATOM flag to HETATM flag
my $atom="ATOM  ";
while(<FILE>)
{
 if ($_=~ m/$ARGV[1]/)
 {
  $_ =~ s/$atom/HETATM/; 
  print $_;
 }
 else
 {
  print $_;
 }
}

close(FILE);

