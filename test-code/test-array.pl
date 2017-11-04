#!/usr/bin/perl -w
use strict;
use warnings;

my $index = 0;
my $flag = 0;
my @components = ();

$index++;
if ($flag and @components) {
	print "check $index true\n";
}
print "B flag = $flag\n";
$flag ++;
$index++;
print "A flag = $flag\n";
if ($flag and @components) {
	print "check $index true\n";
}

push @components, "data";
$index++;
if ($flag and @components) {
	print "check $index true\n";
}



