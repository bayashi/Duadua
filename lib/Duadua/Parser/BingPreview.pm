package Duadua::Parser::BingPreview;
use strict;
use warnings;
use Duadua::Util;

sub try {
    my ($class, $d) = @_;

    if ( index($d->ua, 'BingPreview/') > -1
                && index($d->ua, 'Mozilla/') == 0 ) {
        my $h = _set_property($d, 'BingPreview');

        if ($d->opt('version')) {
            my ($version) = ($d->ua =~ m!BingPreview/([\d.a-z]+)!);
            version($h, $version) if $version;
        }

        return $h;
    }
}

sub _set_property {
    my ($d, $name) = @_;

    my $h = { name => $name };
    bot($h);

    if ( index($d->ua, 'Windows') > -1 ) {
        windows($h);
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
