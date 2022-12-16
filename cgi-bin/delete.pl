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
HTML
my $q = CGI->new;

my $user = 'alumno';
my $password = 'pweb1';
my $dsn = "DBI:MariaDB:database=pweb1;host=192.168.0.103";
my $dbh = DBI->connect($dsn, $user, $password) or die("No se pudo conectar");

my $nombre = $q->param('nombre');

my $sth = $dbh->prepare("DELETE FROM Paginas WHERE nombre=?");
$sth->execute($nombre);

$sth->finish;
print <<HTML;
<h1>Borrado con exito</h1>
<h2><a href="list.pl">Retroceder</a></h2>
</body>
</html>
HTML