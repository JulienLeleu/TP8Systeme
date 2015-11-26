#!/usr/bin/perl

use Socket;

sub client {
	$port = 7;
    $adresse = inet_aton("localhost") or die "inet_aton: $!";
    $adresse_complete = sockaddr_in($port, $adresse) or die "sockaddr: $!";
	$protocole = getprotobyname('tcp');
	
	socket(SERVER, PF_INET, SOCK_STREAM, $protocole) or die "socket: $!";	
    connect(SERVER, $adresse_complete) or die "connect: $!";
	
	SERVER->autoflush(1);
    while (<STDIN>)
    {
        print SERVER "echo: $_\n";
        print scalar <SERVER>;
    }
    close(SERVER);
}

client();
