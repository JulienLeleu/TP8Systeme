#!/usr/bin/perl

use Socket;
use POSIX ":sys_wait_h";

$nbRepetitions = @ARGV[0];

$protocole = getprotobyname('tcp');
$port = 8080;

socket(LISTEN, PF_INET, SOCK_STREAM, $protocole) or die "socket: $!";
setsockopt(LISTEN, SOL_SOCKET, SO_REUSEADDR, 1) or die "setsockopt: $!";
bind(LISTEN, sockaddr_in($port, INADDR_ANY)) or die "bind: $!";

listen(LISTEN, 10) or die "listen: $!";

for (;;)
{
    accept(CLIENT, LISTEN) or die "accept: $!";
    if (fork() == 0)
    {
   		print "client connecté\n";
        autoflush CLIENT 1;
        for ($i = 0; $i < $nbRepetitions; $i++) {
    		print CLIENT "Bonjour\n";
   		}
        print "client deconnecté\n";
        exit 0;
	}
	close CLIENT;		#ferme le HANDLER, /!\ ne tue pas le processus.
    do {
        $pid = waitpid(-1, WNOHANG);		#Tue les processus
        if ($pid == 0)
        {
            print "Personne terminé\n";
        }
        else
        {
            print "Fils de pid $pid terminé\n";
        }
    } while ($pid > 0);
}
