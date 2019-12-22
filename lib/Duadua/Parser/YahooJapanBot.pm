package Duadua::Parser::YahooJapanBot;
use strict;
use warnings;

sub try {
    my ($class, $d) = @_;

    if ( index($d->ua, 'http://help.yahoo.co.jp/help') > -1 ) {
        return {
            name   => 'Yahoo!Japan Crawler',
            is_bot => 1,
        };
    }

    if ( index($d->ua, 'Y!J-') > -1 && $d->ua =~ m|Y!J-[A-Z]+| ) {
        return {
            name   => 'Yahoo!Japan Crawler',
            is_bot => 1,
        };
    }
}

1;

__END__

=head1 METHODS

=head2 try

Do parse


=head1 AUTHOR

Dai Okabayashi E<lt>bayashi@cpan.orgE<gt>


=head1 LICENSE

C<Duadua> is free software; you can redistribute it and/or modify it under the terms of the Artistic License 2.0. (Note that, unlike the Artistic License 1.0, version 2.0 is GPL compatible by itself, hence there is no benefit to having an Artistic 2.0 / GPL disjunction.) See the file LICENSE for details.

=cut