#!/usr/bin/perl
#
# $Id$
# $Log$
# Revision 1.1  2005/07/28 23:55:12  nadya
# Initial revision
#
#
# AUTHOR: Timothy L. Bailey
# CREATE DATE: 3-22-99

$PGM = $0;			# name of program
$PGM =~ s#.*/##;                # remove part up to last slash
@args = @ARGV;			# arguments to program
$| = 1;				# flush after all prints
$SIG{'INT'} = 'cleanup';	# interrupt handler
# Note: so that interrupts work, always use for system calls:
# 	if ($status = system($command)) {&cleanup($status)}

# requires
push(@INC, split(":", $ENV{'PATH'}));	# look in entire path

# defaults

$usage = <<USAGE;		# usage message
  USAGE:
	$PGM [-r <name>]

	[-r <name>]		read and replace named file

	Copy a FASTA sequence file changing any duplicate sequence names
	to insure there are no duplicates.  This is done by appending "_i",
	where "i" is the copy number, to any names which are duplicates.

	Also replaces any cntrl-As with spaces.

	Reads standard input.
	Writes standard output.

        Copyright
        (1999) The Regents of the University of California.
        All Rights Reserved.
        Author: Timothy L. Bailey
USAGE

$nargs = 0;			# number of required args
if ($#ARGV+1 < $nargs) { &print_usage("$usage", 1); }

# get input arguments
while ($#ARGV >= 0) {
  $_ = shift;
  if ($_ eq "-h") {				# help
    &print_usage("$usage", 0);
  } elsif ($_ eq "-r") {			# replace
    $file = shift;
  } else {
    &print_usage("$usage", 1);
  }
}

# open input and output
if ($file) {
  $in = "$file"; $out = "$PGM.$$.tmp";
} else {
  $in = "-"; $out = "-";
}
open(IN, "<$in") || die("Unable to open file $in : $!\n");
open(OUT, ">$out") || die("Unable to open file $out : $!\n");

while (<IN>) {
  s/\x01/ /g;					# remove pesky ^As
  if (/^>(\S+)/) {				# id line
    $name = $1;
    $cnt = ++$cnt{$name};			# count occurences of name
    if ($cnt > 1) {				# duplicate name
      s/^>$name/>${name}_$cnt/;			# append _i to name
    }
  }
  print OUT "$_";
};

if ($file) { rename($out, $file); }

# cleanup files
&cleanup($status);

################################################################################
#                       Subroutines                                            #
################################################################################

################################################################################
#
#       print_usage
#
#	Print the usage message and exit.
#
################################################################################
sub print_usage {
  local ($usage, $status) = @_;

  if (-c STDOUT) {			# standard output is a terminal
    open(C, "| more");
    print C $usage;
    close C;
  } else {				# standard output not a terminal
    print STDERR $usage;
  }

  exit $status;
}

################################################################################
#       cleanup
#
#       cleanup stuff
#
################################################################################
sub cleanup {
  local($status, $msg) = @_;
  if ($status && "$msg") {print STDERR "$msg: $status\n";}
  if ($file && -e $out) { unlink $out; }
  exit($status);
}
