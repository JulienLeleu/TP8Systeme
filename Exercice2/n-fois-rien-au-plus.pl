#!/usr/bin/perl
use POSIX ":sys_wait_h";

$n = $ARGV[0] or die "argument : $!";
$i = 1;
$kids = 0;

while(<>)
{
    $kidpid = waitpid(-1,WNOHANG);
    if(($kidpid != undef) && ($kidpid != -1))
    {
    	print("Fin auto de $kidpid\n");
    	$kids--;
    }    
    if($kids >= $n)
    {
    	print("Attente de la fin d'un fils...\n");
    	$kid = wait();
    	$kids--;
    	print("Fin de : $kid\n");
    }
    
    $pid = fork();
    if($pid != 0)
    {
    	print("Création du fils $pid\n");
    	$kids++;
    }
    else 
    {
    	`perl rien.pl`;
    	exit 0;
    } 
}