package Duadua::Parser;
use strict;
use warnings;
use Module::Pluggable::Object;

Module::Pluggable::Object->new(
    search_path => [ __PACKAGE__ ],
    require     => 1,
)->plugins;

my $BLANK_UA = {
    name       => 'UNKNOWN',
    is_bot     => 0,
    is_android => 0,
    is_ios     => 0,
    is_linux   => 0,
    is_windows => 0,
};

sub parse {
    my ($class, $d) = @_;

    # Blank or '-'
    if ($d->ua eq '' || $d->ua eq '-') {
        return $BLANK_UA;
    }

    for my $m (qw/
        Googlebot

        MicrosoftEdge
        GoogleChrome
        MozillaFirefox
        AppleSafari

        Bingbot
        Baiduspider

        Twitterbot
        FacebookCrawler
        Slackbot

        AdIdxBot
        BingPreview
    /) {
        if ( my $res = (__PACKAGE__ . "::$m")->try($d) ) {
            return $res;
        }
    }

    return $BLANK_UA;
}

1;

__END__

=encoding UTF-8

=head1 NAME

Duadua::Parser - Parser of Duadua


=head1 METHODS

=head2 parse($d_obj)

Do parse


=head1 AUTHOR

Dai Okabayashi E<lt>bayashi@cpan.orgE<gt>


=head1 LICENSE

C<Duadua> is free software; you can redistribute it and/or modify it under the terms of the Artistic License 2.0. (Note that, unlike the Artistic License 1.0, version 2.0 is GPL compatible by itself, hence there is no benefit to having an Artistic 2.0 / GPL disjunction.) See the file LICENSE for details.

=cut
