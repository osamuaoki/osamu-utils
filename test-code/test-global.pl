#!/usr/bin/perl -w
use strict;
use warnings;

my $foo = "global";
print "pre0  -> $foo\n";

sub level1 ();
sub level2 ();

sub level1 ()
{
print "pre1  -> $foo\n";
my $foo = "level1";
print "post1 -> $foo\n";
}


sub level2 ()
{
print "pre2  -> $foo\n";
my $foo = "level2";
my $bar = "Level2";
print "mid2  -> $foo\n";
print "mid2  -> $bar\n";
level1();
print "post2 -> $foo\n";
print "post2 -> $bar\n";
}

level2();

print "post0 -> $foo\n";

