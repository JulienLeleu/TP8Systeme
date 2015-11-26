#!/usr/bin/perl

use Socket;

sub client {
    $adresse = inet_aton("localhost") or die "inet_aton: $!";
    $adresse_complete = sockaddr_in(8080, $adresse) or die "sockaddr: $!";
	$protocole = getprotobyname('tcp');
	
	socket(SERVER, PF_INET, SOCK_STREAM, $protocole) or die "socket: $!";	
    connect(SERVER, $adresse_complete) or die "connect: $!";

    while (<SERVER>)
    {
        print;
        print SERVER "echo: $_\n";
    }
    close(SERVER);
}

client();
