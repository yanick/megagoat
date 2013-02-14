package Bot::BasicBot::Pluggable::Module::Pythian;

use strict;
use warnings;

use base qw/ Bot::BasicBot::Pluggable::Module /;

sub help {
    return "provide reviewers";
}

sub admin {
    my( $self, $mess ) = @_;

    my @team = qw/ champoux lang portnoy perry pearce han melnikov /;

    my($pick,$ticket) = $mess->{body} =~ /((?:pick)?) reviewer for (\w\w-\d+)/ or return 0;

    my $tickets = $self->get('tickets') || {};

    $tickets->{$ticket} = $team[rand@team] 
        if $pick or not $tickets->{$ticket};

    $self->set( 'tickets' => $tickets );

    return sprintf "reviewer for %s is %s",
        $ticket, $tickets->{$ticket};        

}


1;



