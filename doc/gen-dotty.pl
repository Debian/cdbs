#!/usr/bin/perl

use File::Basename;

print "digraph deps {\n";
foreach (@ARGV) {
	$from = basename($_);
	open(FILE, $_) or die;
	while (<FILE>) {
		if (m!^include.+/([-a-z]+\.mk)!) {
			$to = basename($1);
			print "\"$from\" -> \"$to\";\n";
		}
	}
	close(FILE);
}
print "}\n";
