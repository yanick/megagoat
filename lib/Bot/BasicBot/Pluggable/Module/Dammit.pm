package Bot::BasicBot::Pluggable::Module::Dammit;

use strict;
use warnings;

use base qw/ Bot::BasicBot::Pluggable::Module /;

sub help {
    return "record how damned somebody is";
}

sub admin {
    my( $self, $mess ) = @_;

    if ( $mess->{body} =~ /damnation top (\d+)/ ) {
        my $n = $1;

        my %damned;
        for ( $self->store_keys ) {
            $damned{$_} = $self->get($_);
        }

        my $chart = "the top $n damned are: ";
        for ( reverse sort { $damned{$a} <=> $damned{$b} } keys %damned ) {
            last unless $n-- and $_;
            $chart .= sprintf "%s (%d) ", $_, $damned{$_};
        }

        return $chart;
    }

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



