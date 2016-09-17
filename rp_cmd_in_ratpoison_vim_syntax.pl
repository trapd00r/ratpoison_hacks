#!/usr/bin/perl
# vim: ft=perl:fdm=marker:fmr=#<,#>:fen:et:sw=2:

# script to aid the ratpoison.vim maintainer
# is RAT_CMD present in the ratpoison.vim syntax rules?
# Author: Magnus Woldrich
#   Date: 2016-09-17 14:28:50
use strict;


my $action = "$ENV{HOME}/dev/catpoison/src/actions.h";
my $syntax = "$ENV{HOME}/dev/vim-syntax-ratpoison/syntax/ratpoison.vim";


my @commands;
{
  open(my $fh, '<', $action) or die "$!";
  while(my $line = <$fh>) {
    $line =~ m/RP_CMD \((\w+)\);/ ? push(@commands, $1) : next;
  }
  close $fh or die "$!";
}

my @syntax_commands;

open(my $fh, '<', $syntax) or die "$!";
while(<$fh>) {
  $_ =~ s/^syn keyword ratpoisonCommandArg (.+)\s+contained/$1/ ?
    push(@syntax_commands, split(/\s+/, $_))                    :
    next;
}

for my $c(sort(@commands)) {
  if($c ~~ @syntax_commands) {
    next;
  }
  else {
    printf "\033[31m%20s\033[m is missing from %s\n", $c, 'ratpoison.vim';
  }
}
