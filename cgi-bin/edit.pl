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
my $texto;

my $sth = $dbh->prepare("SELECT texto FROM Paginas WHERE nombre=?");
$sth->execute($nombre);

$texto = $sth->fetchrow;

$sth->finish;
print <<HTML;
<form action="editar.pl">
    <input type="text" name="nombre" value=$nombre readonly><br>
    <label>Editar</label><br>
    <textarea name= "texto" rows="10" cols="50">$texto</textarea><br>
    <input type="submit" value="Enviar">
</form>
<p><a href="../index.html">Cancelar</a></p>
</body>
</html>
HTML