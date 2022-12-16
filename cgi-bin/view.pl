#!/usr/bin/perl -w
use strict;
use warnings;
use DBI;
use CGI;

print "Content-type: text/html\n\n";
print <<HTML;
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
</head>
<body>
<h2><a href="list.pl">Retroceder</a></h2>
HTML
my $q = CGI->new;

my $user = 'alumno';
my $password = 'pweb1';
my $dsn = "DBI:MariaDB:database=pweb1;host=192.168.0.103";
my $dbh = DBI->connect($dsn, $user, $password) or die("No se pudo conectar");

my $nombre = $q->param('nombre');
my $texto;

my $sth = $dbh->prepare("SELECT texto FROM Paginas WHERE nombre=?");
$sth->execute($nombre);

$texto = $sth->fetchrow;
my @lineas = split("\n", $texto);
foreach my $n (@lineas) {
    print matchLine($n);
} 
$sth->finish;
print <<HTML;
</body>
</html>
HTML
sub matchLine{
  my $n = $_[0];
  my $codigo;
  if( $n =~ /^(#){1}([^#].+)/){
    $codigo = "<h1>$2</h1><hr>";
  }
  elsif($n =~ /^(#){2}([^#].+)/){
    $codigo = "<h2>$2</h2>";
  }
  elsif($n =~ /^(#){3}([^#].+)/){
    $codigo = "<h3>$2</h3>";
  }
  elsif($n =~ /^(#){4}([^#].+)/){
    $codigo = "<h4>$2</h4>";
  }
  elsif($n =~ /^(#){5}([^#].+)/){
    $codigo = "<h5>$2</h5>";
  }
  elsif($n =~ /^(#){6}([^#].+)/){
    $codigo = "<h6>$2</h6>";
  }
  elsif($n =~ /^[^#\*~](.+)/){
    $codigo = "<p>$1</p>";
  }
  elsif($n =~ /^(~){2}([^#].+)(~{2})/){
    $codigo = "<s>$2</s>";
  }
  elsif($n =~ /^(\*){1}([^\*].+)(\*{1})/){
    $codigo = "<p><i>$2</i></p>";
  }
  elsif($n =~ /^(\*){2}([^\*].+)(\*{2})/){
    $codigo = "<p><b>$2</b></p>";
  }
  elsif($n =~ /^(\*){3}([^\*].+)(\*{3})/){
    $codigo = "<p><strong><i>$2</i></strong></p>";
  }
  else{
    $codigo = "<br>";
  }
  return $codigo;
}
