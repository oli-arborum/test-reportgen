#!/usr/bin/perl -w

use strict;
use DBI;
use POSIX qw(strftime);

my $loremipsum = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet,";

my @liarr = split( ' ', $loremipsum );

my $dbargs = {AutoCommit => 0, PrintError => 1};
my $dbh = DBI->connect("dbi:SQLite:dbname=msg.db", "", "", $dbargs);

my $t = time() - 24*60*60*10; # start 10 days back

for( my $i=0; $i<100; ++$i ){
  $t += int(rand(1000));
  my $ms = int(rand(1000));
  my $len = int(rand(20))+5;
  my $off = int(rand(@liarr - $len)); # offset
  my $msg = "";
  for( my $j = 0; $j < $len; ++$j ) {
    if( length($msg) > 0 ) { $msg .= " "; }
    $msg .= $liarr[$j + $off];
  }
  my $type = int(rand(6));
  print strftime( "%d.%m.%Y %H:%M:%S", localtime($t) ) . "." . sprintf("%03d", $ms) . " -> $msg\n";

  $dbh->do("INSERT INTO messages (timestamp, msec, type, message) VALUES ($t, $ms, $type, \"$msg\");");
  if ($dbh->err()) { die "$DBI::errstr\n"; }
  $dbh->commit();
}


$dbh->disconnect();

