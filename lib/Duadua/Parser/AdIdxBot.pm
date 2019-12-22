package Duadua::Parser::AdIdxBot;
use strict;
use warnings;
use Duadua::Util;

sub try {
    my ($class, $d) = @_;

    ####
    #
    # AdIdxBot
    # https://www.bing.com/webmaster/help/which-crawlers-does-bing-use-8c184ec0
    #
    ####

    if ( index($d->ua, 'adidxbot/') > -1
            && index($d->ua, '+http://www.bing.com/bingbot.htm') > -1
                && index($d->ua, 'Mozilla/') > -1 ) {
        return _set_property($d, 'Bingbot');
    }
}

sub _set_property {
    my ($d, $name) = @_;

    my $h = { name => $name };
    bot($h);

    if ( index($d->ua, 'Windows') > -1 ) {
        windows($h);
    }
    elsif ( index($d->ua, 'iPhone') > -1 ) {
        ios($h);
    }

    return $h;
}

1;

__END__

=encoding UTF-8

=head1 METHODS

=head2 try

Do parse


=head1 AUTHOR

Dai Okabayashi E<lt>bayashi@cpan.orgE<gt>


=head1 LICENSE

C<Duadua> is free software; you can redistribute it and/or modify it under the terms of the Artistic License 2.0. (Note that, unlike the Artistic License 1.0, version 2.0 is GPL compatible by itself, hence there is no benefit to having an Artistic 2.0 / GPL disjunction.) See the file LICENSE for details.

=cut
