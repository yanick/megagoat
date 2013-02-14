package Bot::BasicBot::Pluggable::Module::Jira;

use strict;
use warnings;

use JIRA::Client;

use base qw/ Bot::BasicBot::Pluggable::Module /;

sub help {
    return "JIRA";
}

sub told {
    my( $self, $mess ) = @_;

    if ( $mess->{body} =~ /rev(\d+)/ ) {
        return "rev$1 url: https://XXX.jira.com/source/changelog/YY?cs=$1";
    }

    my( $ticket ) = $mess->{body} =~ /\s(PY-\d+)/
        or return 0;

    my $client = JIRA::Client->new(
        'https://XXX.jira.com', 
        'user',
        'password',
    );

    my $issue = eval { $client->getIssue($ticket) };

    warn $@ if $@;
    return 0 unless $issue;

    return sprintf "%s: %s (%s) - %s",
        $ticket, $issue->{summary}, $issue->{assignee},
        "https://pythian.jira.com/browse/$ticket";
}


1;



