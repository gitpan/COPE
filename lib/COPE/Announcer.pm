# $Id: Announcer.pm,v 1.3 1997/07/25 10:12:41 schuller Exp $
# Copyright (c) 1997 Lunatech Research / Bart Schuller <schuller@lunatech.com>
# See the file "Artistic" in the distribution for licensing and
# (lack of) warranties.

package COPE::Announcer;

use strict;
use IO::Handle;
use Socket;
use COPE::CORBA::ORB;

# Subs

sub announce ($$) {
    my($name, $value) = @_;
    my($msg,$index) = ('ADD ', 4);
    CORBA::ORB::_marshal_string(\$msg, \$index, 0, $name);
    CORBA::ORB::_marshal_string(\$msg, \$index, 0, $value);
    my $broadcaster = new COPE::Announcer;
    $broadcaster->shout();
    return $broadcaster->send_and_get_message($msg);
}

sub resolve ($) {
    my($name) = @_;
    my($msg,$index) = ('GET ', 4);
    CORBA::ORB::_marshal_string(\$msg, \$index, 0, $name);
    my $broadcaster = new COPE::Announcer;
    $broadcaster->shout();
    $msg = $broadcaster->send_and_get_message($msg);
    return undef if !defined $msg;
    $index = 0;
    my $value = CORBA::ORB::_unmarshal_string(\$msg,\$index,0);
    return $value;
}

sub daemon () {
    my %db;
    my $listener = new COPE::Announcer;
    $listener->listen();
    while (1) {
        my $msg = $listener->get_message(undef);
        next if !$msg;
        my $cmd = substr($msg, 0, 4);
        my $index = 4;
        if ($cmd eq 'ADD ') {
            my $name = CORBA::ORB::_unmarshal_string(\$msg,\$index,0);
            my $value = CORBA::ORB::_unmarshal_string(\$msg,\$index,0);
            $db{$name} = $value;
            $listener->send_message('ADDED');
            next;
        }
        if ($cmd eq 'GET ') {
            my $name = CORBA::ORB::_unmarshal_string(\$msg,\$index,0);
            $msg = ''; $index = 0;
            CORBA::ORB::_marshal_string(\$msg,\$index,0,$db{$name});
            $listener->send_message($msg);
            next;
        }
    }
}

# Class methods

sub new {
    my($class) = @_;
    my $self = { sock => new IO::Handle };
    socket($self->{sock}, PF_INET, SOCK_DGRAM, getprotobyname('udp')) || die "socket: $!";
    return bless $self, $class;
}

# Object methods

sub listen {
    my($self) = @_;
    bind($self->{sock}, scalar sockaddr_in(3228, INADDR_ANY)) || die "bind: $!";
}

sub shout {
    my($self) = @_;
    $self->{peer} = sockaddr_in(3228, INADDR_BROADCAST);
    setsockopt $self->{sock}, SOL_SOCKET, SO_BROADCAST, undef;
}

sub get_message {
    my($self,$timeout) = @_;
    my($msg,$rout);
    my $rin = '';
    vec($rin,fileno($self->{sock}),1) = 1;
    select($rout=$rin, undef, undef, $timeout);
    if (vec($rout,fileno($self->{sock}),1)) {
        $self->{peer} = recv $self->{sock}, $msg, 4096, 0;
        return $msg;
    } else {
        return undef;
    }
}

sub send_message {
    my($self, $msg) = @_;
    send $self->{sock}, $msg, 0, $self->{peer};
}

sub send_and_get_message {
    my($self,$in) = @_;
    my $out;
    for (my $i=0; $i < 10; $i++) {
        $self->send_message($in);
        last if defined($out = $self->get_message(1));
    }
    return $out;
}

1;
