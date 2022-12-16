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

my $texto = $q->param('texto');
my $nombre = $q->param('nombre');

my $sth = $dbh->prepare("INSERT INTO Paginas(nombre,texto) VALUES(?,?)");
$sth->execute($nombre, $texto);

$sth->finish;
print <<HTML;
<center>
<textarea rows="10" cols="50">$texto</textarea>
<h2>Página Grabada</h2>
<p><a href="list.pl">Listado</a></p>
</center>
</body>
</html>
HTML
