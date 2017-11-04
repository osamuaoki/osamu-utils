#!/usr/bin/perl -w
# vim:se ai sts=4:
use strict;
use warnings;

my $base = "ssh://git.debian.org/git/collab-maint/devscripts.git";

open(REFS, "-|", 'git', 'ls-remote', $base) || die "You must have the git package installed\n";

while (<REFS>) {
    my $ref;
    chomp;
    if (m&^\S+\s+([^\^\{\}]+)$&) {
	$ref = $1;
    } else {
	$ref = undef;
    }
}
