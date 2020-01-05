package Duadua::Parser::AppleSafari;
use strict;
use warnings;
use Duadua::Util;

sub try {
    my ($class, $d) = @_;

    return if index($d->ua, 'http') > -1;

    if ( index($d->ua, 'Mozilla/5.0 (Mac') == 0 && index($d->ua, 'Safari/') > -1 ) {
        my $h = {
            name   => 'Apple Safari',
            is_ios => 1,
        };

        if ($d->opt('version')) {
            my ($version) = ($d->ua =~ m!Safari/([\d.]+)!);
            version($h, $version) if $version;
        }

        return $h;
    }

    if ( index($d->ua, 'Mozilla/5.0') == 0
        && Duadua::Util->ordering_match($d, [' AppleWebKit/', ' Version/', ' Safari/']) ) {
        my $h = {
            name => 'Apple Safari',
        };

        if ($d->opt('version')) {
            my ($version) = ($d->ua =~ m!Safari/([\d.]+)!);
            version($h, $version) if $version;
        }

        return Duadua::Util->set_os($d, $h);
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
