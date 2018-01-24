#!/usr/bin/perl -w
use strict;
use warnings;
use Getopt::Long;


my $verbose = '';
my $all = 0;

GetOptions ('verbose!' => \$verbose, 'all!' => \$all);

print "all -> '$all'\n";
print "verbose -> '$verbose'\n";

