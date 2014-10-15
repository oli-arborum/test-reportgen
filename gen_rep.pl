#!/usr/bin/perl -w

use strict;
use DBI;

sub escape_latex
{
  my($text) = @_;
  $text =~ s/(\\)/\\textbackslash /g;
  $text =~ s/([\{\}_\^#&\$%~])/\\$1/g;
  return $text;
}

my $dbargs = {AutoCommit => 0, PrintError => 1};
my $dbh = DBI->connect("dbi:SQLite:dbname=msg.db", "", "", $dbargs);

my ($timestamp, $ms, $type, $message) = "";

# @TODO: limits (min and max timestamp)

my $res = $dbh->selectall_arrayref("SELECT strftime('%d.%m.%Y %H:%M:%S', timestamp, 'unixepoch'), msec, type, message FROM messages ORDER BY timestamp, msec;");
foreach my $row (@$res) {
  ($timestamp, $ms, $type, $message) = @$row;
  # print $timestamp . "." . sprintf("%03d", $ms) . " -> ($type) $message\n";
  print $timestamp . "." . sprintf("%03d", $ms) . " & $type & " . escape_latex($message) . "\\\\\n\\hline\n";
}

$dbh->disconnect();

