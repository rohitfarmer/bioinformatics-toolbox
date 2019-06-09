#!/usr/bin/perl 

# This script was used to convert the format of non bonded parameters from GAFF to Gromacs format (ffnonbonded.itp).
# The input required was a file containing the list of non bonded parameters from GAFF in Amber suite. 
use strict;
use warnings;

if ($#ARGV < 0) {
    print STDERR "Usage: $0 <file.txt>\n";
    exit -1;
}

open(FILE, "$ARGV[0]") || die "Can't open file";

while(<FILE>)
{
    
    chomp($_);
    my $atomtype = substr($_,2,2);
    my $sigma   = sprintf("%.5e",(substr($_,13,6) * ((2**(5/6))/10)));
    my $epsilon  = sprintf("%.5e",(substr($_,22,6) * 4.184));
    my $description=substr($_,41);
    if($atomtype=~ m/^c/  and not $atomtype=~ m/cl/)
    {    
     print $atomtype,"           6      12.01    0.0000  A   ",$sigma,"  ",$epsilon," ; $description\n";
    }
    elsif($atomtype=~ m/^h/)
    {    
     print $atomtype,"           1       1.008   0.0000  A   ",$sigma,"  ",$epsilon," ; $description\n";
    }
    elsif($atomtype=~ m/^o/)
    {    
     print $atomtype,"           8      16.00    0.0000  A   ",$sigma,"  ",$epsilon," ; $description\n";
    }
    elsif($atomtype=~ m/^n/)
    {    
     print $atomtype,"           7      14.01    0.0000  A   ",$sigma,"  ",$epsilon," ; $description\n";
    }
    elsif($atomtype=~ m/^s/)
    {    
     print $atomtype,"          16      32.06    0.0000  A   ",$sigma,"  ",$epsilon," ; $description\n";
    }
    elsif($atomtype=~ m/^p/)
    {    
     print $atomtype,"          15      30.97    0.0000  A   ",$sigma,"  ",$epsilon," ; $description\n";
    }
    elsif($atomtype=~ m/^f/)
    {    
     print $atomtype,"           9      19.00    0.0000  A   ",$sigma,"  ",$epsilon," ; $description\n";
    }
    elsif($atomtype=~ m/^cl/)
    {    
     print $atomtype,"          17      35.45    0.0000  A   ",$sigma,"  ",$epsilon," ; $description\n";
    }
    elsif($atomtype=~ m/^br/)
    {    
     print $atomtype,"          35      79.90    0.0000  A   ",$sigma,"  ",$epsilon," ; $description\n";
    }
    elsif($atomtype=~ m/^i/)
    {    
     print $atomtype,"          53     126.9     0.0000  A   ",$sigma,"  ",$epsilon," ; $description\n";
    }
}

close(FILE);
