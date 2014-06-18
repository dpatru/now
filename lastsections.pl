#!/usr/bin/perl -sn

BEGIN { 
  if (! $n || $n < 1 ) {
    die "usage: $ARGV[0] -n=3";
  } 
  # print $n;
  my @sections;
}

if ( 0 > $#sections ) {
  push(@sections, "");
}

if ($_ eq "\n") {
  if ($n <= $#sections + 1 ) {
    #print "$n <= $#sections\n";
    shift @sections;
  }
  push @sections, "";
}

$sections[$#sections] .= "$_";

END {
  for my $section (@sections) { 
    print "$section"; 
  }
}
