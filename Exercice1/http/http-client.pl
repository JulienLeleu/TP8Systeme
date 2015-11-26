#!/usr/bin/perl

use Socket;

sub client {
	$host = @ARGV[0];
	$ressource = @ARGV[1];
	$port = 80;
    $adresse = inet_aton($host) or die "inet_aton: $!";
    $adresse_complete = sockaddr_in($port, $adresse) or die "sockaddr: $!";
	$protocole = getprotobyname('tcp');
	
	socket(SERVER, PF_INET, SOCK_STREAM, $protocole) or die "socket: $!";	
    connect(SERVER, $adresse_complete) or die "connect: $!";
	
	SERVER->autoflush(1);
	print SERVER "GET /$ressource HTTP/1.1\nHost: $host\n\n";
	while (<SERVER>)
    {
        print ;
    }
    close(SERVER);
}

client();
