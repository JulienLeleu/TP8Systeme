#!/usr/bin/perl

$n = $ARGV[0] or die "Nombre d'arguments insuffisants";
@fils = ();

for($i = 0; $i < $n; $i++)
{
    $pid = fork();
    if($pid != 0) {
		print("Création du fils $i :", $pid, "\n");
		$fils[$i] = $pid;
    }
    else {
		system "./rien.pl";
		exit 1;
    }
}

for($i = 0; $i < $n; $i++) {
    $pid = waitpid($fils[$i],0);
    print("Fin de ", $pid,"\n");
}
