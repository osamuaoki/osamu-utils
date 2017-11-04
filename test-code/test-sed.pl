#!/usr/bin/perl -w
# vim:se ai sts=4:
use strict;
use warnings;

my $filenamemangle = "aaaabbbbaaaacccc";

$filenamemangle =~ s&^(aaaa)bbbb\1cccc$&good&;

print "$filenamemangle\n";

