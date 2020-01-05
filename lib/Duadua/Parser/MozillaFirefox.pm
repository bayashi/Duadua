package Duadua::Parser::MozillaFirefox;
use strict;
use warnings;
use Duadua::Util;

sub try {
    my ($class, $d) = @_;

    if ( index($d->ua, 'Mozilla/5.0 (') == 0 && index($d->ua, 'Firefox/') > -1 ) {
        my $h = {
            name => 'Mozilla Firefox',
        };

        if ($d->opt('version')) {
            my ($version) = ($d->ua =~ m! Firefox/([\d.]+)!);
            version($h, $version) if $version;
        }

        return Duadua::Util->set_os($d, $h);
    }

    if ( index($d->ua, 'Mozilla/5.0 (') == 0 && index($d->ua, 'FxiOS/') > -1 ) {
        my $h = {
            name   => 'Mozilla Firefox iOS',
            is_ios => 1,
        };

        if ($d->opt('version')) {
            my ($version) = ($d->ua =~ m! FxiOS/([\d.]+)!);
            version($h, $version) if $version;
        }

        return $h;
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
