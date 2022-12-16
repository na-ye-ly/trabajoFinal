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
<style>
form{
  display: inline-block;
}
</style>
</head>
<body>
HTML
my $q = CGI->new;

my $user = 'alumno';
my $password = 'pweb1';
my $dsn = "DBI:MariaDB:database=pweb1;host=192.168.0.103";
my $dbh = DBI->connect($dsn, $user, $password) or die("No se pudo conectar");

my $sth = $dbh->prepare("SELECT nombre FROM Paginas");
$sth->execute();

print <<HTML;
<h2>Nuestras Páginas de Wiki</h2>
<ul>
HTML
while(my $row = $sth->fetchrow){
  print "<form action = \"view.pl\">\n";
  print "<li><button name=\"nombre\" value=\"$row\">$row</button></li>\n";
  print "</form>\n";
  print "<form action = \"delete.pl\">\n";
  print "<button name=\"nombre\" value=\"$row\">X</button>\n";
  print "</form>\n";
  print "<form action = \"edit.pl\">\n";
  print "<button name=\"nombre\" value=\"$row\">E</button>\n";
  print "</form><br>\n";
}
$sth->finish;
print <<HTML;
</ul>
<hr>
<p><a href="../new.html">Nueva Página</a></p>
<p><a href="../index.html">Volver al Inicio</a></p>
</body>
</html>
HTML
