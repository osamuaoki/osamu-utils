#!/usr/bin/perl -w
use strict;
use warnings;
use Text::ParseWords;
use Dpkg::IPC;

my $msg;
my $msg_e;
my $cmdline = './test-stderr.sh 2>&1';
my @cmd = shellwords($cmdline);
foreach my $p (@cmd) {
	print "\$p=$p\n";
}
print "=====\n";
$msg = `$cmdline`;
print "backtick around 2>&1:\n";
print $msg;
print "=====\n";
spawn(exec => \@cmd,
      to_string => \$msg,
      error_to_string => \$msg_e,
      nocheck => 1,
      wait_child => 1);

print "to_string to \$msg with 2>&1:\n";
print $msg;
print "=====\n";
print "error_to_string to \$msg_e with 2>&1:\n";
print $msg_e;
print "=====\n";
my $msg;
spawn(exec => \@cmd,
      to_string => \$msg,
      error_to_string => \$msg,
      nocheck => 1,
      wait_child => 1);

print "to_string and error_to_string to \$msg with 2>&1:\n";
print $msg;
print "=====\n";


print "backtick and error code for false\n";
`false`;
print ("\$?       # Return value: ");
print ($?);
print "\n";
print ("\$?>>8    # HIGH 8 bits:  ");
print ($?>>8);
print "\n";
print ("\$? & 255 # LOW 8 bits:   ");
print ($? & 255);
print "\n";


use File::Temp qw/tempfile tempdir/;

my $tmp = tempdir("/tmp/uscan.XXXXXXXXXXX");

print "\$tmp=$tmp\n";
