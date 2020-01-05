package Duadua::Parser::MicrosoftInternetExplorer;
use strict;
use warnings;
use Duadua::Util;

sub try {
    my ($class, $d) = @_;

    if ( index($d->ua, 'MSIE ') > -1 && index($d->ua, 'Mozilla/') == 0 && index($d->ua, 'Windows ') > -1 ) {
        my $h = {
            name       => 'Internet Explorer',
            is_windows => 1,
        };

        if ($d->opt('version')) {
            my ($version) = ($d->ua =~ m! MSIE ([\d.]+); !);
            version($h, $version) if $version;
        }

        return $h;
    }

    if ( index($d->ua, 'Trident/') > -1 && index($d->ua, ' rv:1') > -1 && index($d->ua, 'Mozilla/') == 0 && index($d->ua, 'Windows ') > -1 ) {
        my $h = {
            name       => 'Internet Explorer',
            is_windows => 1,
        };

        if ($d->opt('version')) {
            my ($version) = ($d->ua =~ m! rv:([\d.]+)!);
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
