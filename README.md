# Bioinformatics Toolbox

Collection of scripts written in Perl or Python for some everyday as well as specific Bioinformatics tasks.

## Sequence Analysis

**count.pl** : Counts the number of sequences in a multiple FASTA file.  
*Usage : count.pl <file.fasta>*

**filter_duplicate.pl** : Filters duplicate sequences in a multiple FASTA file.  
*Usage : filter_duplicate.pl <file.fasta>*  
*Note : Depends on BioPerl*

**length.pl** : Calculates length of sequence(s) in FASTA format.  
*Usage : length.pl <file.fasta>*

**blastxml_query_coverage.pl** : Parse BLAST XML output (downloaded from the NCBI BLAST website), to fetch sequences with a desired query coverage (percentage).  
*Usage : blastxml_query_coverage.pl <file.xml> <query-coverage %>*  
*Note : Depends on XML::Simple*

**extractdomains_refseq.pl** : Reads hmmsearch output from HMMER software and extracts matched sequences in FASTA format.  
*Usage : extractdomains_refseq.pl <hmmsearch output file>*  
*Note : hmmsearch must be done against **refseq** database.*

**extractdomains_trembl.pl** : Reads hmmsearch output from HMMER software and extracts matched sequences in FASTA format.  
*Usage : extractdomains_trembl.pl <hmmsearch output file>*  
*Note : hmmsearch must be done against **trembl** database.*

## Protein Structure Analysis

**atom2hetatm.pl** : Converts the ATOM flag to HETATM flag for the ligand residue in the HADDOCK output file.  
*Usage : atom2hetatm.pl <file.pdb> <residue name>*

**rmsd_matt.pl** : Calculates the RMSD between a reference structure and a structure extracted from a file containing multiple PDB (generated using VMD).  
*Usage : rmsd_matt.pl <reference-structure.pdb> <multi.pdb>*
