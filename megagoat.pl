#!/usr/bin/perl 

use strict;
use warnings;

use lib 'lib';

use Bot::BasicBot::Pluggable;


my $bot = Bot::BasicBot::Pluggable->new(
                      channels => [ '#yanick' ],
                      server   => "",
                      port     => "",
                      ssl => 1,
                      nick     => "megagoat",
                      username => "megagoat",
                      name     => "Yet Another Pluggable Bot",
                );

$bot->load('Karma');
$bot->load('Infobot');
$bot->load('Pythian');
$bot->load('Jira');
$bot->load('Eliza');
$bot->load('Dammit');
$bot->run;

