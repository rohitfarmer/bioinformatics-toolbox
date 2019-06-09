#!/usr/bin/perl

use warnings;
use strict;

my $Domain=0;

while( <> ) {
	
	
	if ($_=~m/\=\=\sdomain/) # Search for the line which starts with ==domain num and read the number of the domain
	{
	$Domain++;

	}
}
print "Number of domains:",$Domain;

