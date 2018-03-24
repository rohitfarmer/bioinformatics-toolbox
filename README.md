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

## Protein Structure Analysis

**atom2hetatm.pl** : Converts the ATOM flag to HETATM flag for the ligand residue in the HADDOCK output file.  
*Usage : atom2hetatm.pl <file.pdb> <residue name>*

**rmsd_matt.pl** : Calculates the RMSD between a reference structure and a structure extracted from a file containing multiple PDB (generated using VMD).  
*Usage : rmsd_matt.pl <reference-structure.pdb> <multi.pdb>*
