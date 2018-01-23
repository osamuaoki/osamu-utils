#!/usr/bin/perl -w
use strict;
use warnings;

my $foo1 = "ba1r";
my $foo2 = "ba2r";
my $foo3 = "ba3r";

print "$foo1-$foo2.$foo3\n";
print "$foo1\\$foo2'$foo3\n";
print "$foo1\\$foo2" . "_$foo3\n";
print "$foo1/$foo2,$foo3\n";
print "$foo1\t$foo2:$foo3\n";
