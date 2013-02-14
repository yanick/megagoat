package Bot::BasicBot::Pluggable::Module::Dammit;

use strict;
use warnings;

use base qw/ Bot::BasicBot::Pluggable::Module /;

sub help {
    return "provide reviewers";
}

sub admin {
    my( $self, $mess ) = @_;

    my($dammit) = $mess->{body} =~ /dam[mn]it\s+(\S+)/ or return 0;

    $self->set( $dammit => $self->get($dammit)+1 );

    return "$dammit has been damned to the ".
        nth($self->get($dammit)). " circle of Hell";        

}

sub nth {
    my $nbr = shift;

    my $post = $nbr == 1 ? 'st'
             : $nbr == 2 ? 'nd'
             : $nbr == 3 ? 'rd'
             : 'th'
             ;

   return $nbr . $post;

}


1;



