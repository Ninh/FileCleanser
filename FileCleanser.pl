#!/bin/perl -w

use strict;
use warnings;

#use File::Find;						# Use class File::Find
#use Text::CSV_XS;						# Use class CSV_XS or CSV_PP
#use Class::CSV;						# Use class CSV


my $file = $ARGV[0] 					# 1st argument is name of .csv file to open
	or die "Error. Enter name of CSV file.\n";

#my $parser = Text::CSV_PP->new();

open(my $data, '<', $file) 				# Opens $file
	or die "Error. Cannot open file $file.";

#unlink "result.csv" if -e "./result.csv";

open(MYFILE, '>result.csv');			# Declare New File with the name result.csv


while(my $line = <$data>) {				# While $data has next line
	chomp $line;						# Remove trailing whitespace

	$line =~ s/<br \/>//gi;				# Removes HTML break tag <br />
	$line =~ s/<h.+?>//gi;				# Removes Beginning HTML header tags
	$line =~ s/<\/h.+?>//gi;			# Removes Ending HTML header tags
	$line =~ s/<div>//gi;				# Removes Beginning HTML div tag <div>
	$line =~ s/<\/div>//gi;				# Removes Ending HTML div tag </div>
	$line =~ s/<p>//gi;					# Removes Beginning HTML paragraph tag <p>
	$line =~ s/<\/p>//gi;				# Removes Ending HTML paragraph tag </p>
	$line =~ s/<b>//gi;					# Removes Beginning HTML bold tag <b>
	$line =~ s/<\/b>//gi;				# Removes Ending HTML bold tag </b>
	$line =~ s/<i>//gi;					# Removes Beginning HTML italics tag <i>
	$line =~ s/<\/i>//gi;				# Removes Ending HTML italics tag </i>
	$line =~ s/<em>//gi;				# Removes Beginning HTML emphasis tag <em>
	$line =~ s/<\/em>//gi;				# Removes Ending HTML emphasis tag </em>
	$line =~ s/<\/a>//gi;				# Removes Ending HTML anchor tag </a>
	$line =~ s/<a href.+?>//gi;			# Removes all <a href ... > mayo clinic tags

	$line =~ s/ +/ /gi;					# Replaces multiple spaces with single space 
	$line =~ s/" /"/gi;					# Removes space after quotation

	$line =~ s/&amp;/&/gi;				# Replaces HTML ampersand &amp; with &
	$line =~ s/&mdash;/--/gi;			# Replaces HTML em-dash &mdash; with two dashes --

	#$line =~ s/\n.*/|/s;				# Removes newline characters #NEEDS WORK

	print MYFILE $line;					# Prints resultant line into file
}

close(MYFILE);							# Closes result.csv file

print "done\n";							# Prints a done statement to the terminal
