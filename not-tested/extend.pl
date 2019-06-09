#!/usr/bin/perl -w
use strict;

# Open the database containing 10076 sequences
open(FILE1,  "rerun_refseq_trembl_amalgamated_filtered_S_nodash.fasta") || die "can't open file";
my $seq;
my $tag;
my @arr;
my %tag_seq;
my %useful;
while(<FILE1>)
 {
  if($_ =~ m/^\>(.+)/ ) # Match for the fasta tag line and store it in @arr
    {
    $tag = $1;
    push @arr,$1;
    $tag_seq{$tag}= "";
    $tag =~ m/^(.+\|)Domain\_(\d+)/;  # Exclude the Domain_num from the fasta tag line and extract the highest domain number
                                      # To read refseq database
   #$tag =~ m/^(.+)\|Domain\_(\d+)/;  # To read the trembl database

    if(defined($useful{$1}))
     {
      if($useful{$1}<$2)
      {
       $useful{$1}=$2;
      }
       
     }
     else
     {
          $useful{$1}=$2;
     }
  # print "$tag $useful{$1}\n";
    }
  else
    {
     $seq=$_;
     chomp($seq);
     $tag_seq{$tag}.=$seq; # Store the sequence in the has %tag_seq
     }
}
 #print $#arr;
 #print $tag_seq{$arr[0]};
close(FILE1); 

###############################

# Read the original database files
open(DATA2, "refseq_all.fasta") || die "Can't open file";
#open(DATA2, "uniprot_trembl.fasta") || die "Can't open file";

my $name="FOE";
$seq="";
my $domain;

while (<DATA2>)
{
 if($_ =~ m/^>(\S+)/) # Extract the name till there is no space in the fasta tag line
 {
  if(defined($useful{$name}))
  {
   for($domain = $useful{$name}; $domain>0;$domain--) # Iterate the loop till the maximum number of domain name found in the previous block
   {
    #check if the name read exist in the hash storing tag and sequence in the previous block
    #if yes then check whether the corresponding sequence matches and extract the 7 residues on either sides
    if(defined($tag_seq{"${name}Domain_$domain"}))# For refseq database; 
   #if(defined($tag_seq{"${name}|Domain_$domain"}))# For trembl database
    { 
   # The reg exp to extract 7 residues on either side of the sequence matched 
       $seq=~ m/(\w{0,7})($tag_seq{"${name}Domain_$domain"})(\w{0,7})/; # For refseq database
       #$seq=~ m/(\w{0,7})($tag_seq{"${name}\|Domain_$domain"})(\w{0,7})/; # For trembl database
       print ">${name}Domain_$domain\n"; # For refseq database
   #   print ">${name}|Domain_$domain\n"; # For trembl database
       print "$1$2$3\n";
    }
   }
  }
  $name=$1; # Store the name of the squences from the original database
  $seq=""; 
 } 
 else  
 {
  chomp($_);
  $seq.=$_; # Store sequence from the original database
 }
 #print $1,"\n";
}
close(DATA2);



