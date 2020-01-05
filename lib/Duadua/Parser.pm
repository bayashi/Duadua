package Duadua::Parser;
use strict;
use warnings;
use Module::Pluggable::Object;
use Duadua::Util;

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
        Bingbot
        AdIdxBot
        BingPreview

        MicrosoftEdge
        Opera
        GoogleChrome
        MicrosoftInternetExplorer
        MozillaFirefox
        AppleSafari

        Baiduspider

        Twitterbot
        FacebookCrawler
        Slackbot

        YahooSlurp
        YahooJapanBot

        HTTPClients
    /) {
        if ( my $res = (__PACKAGE__ . "::$m")->try($d) ) {
            return $res;
        }
    }

    if ( my $is_bot = $class->_detect_general_bot($d) ) {
        return $is_bot;
    }

    return $BLANK_UA;
}

sub _detect_general_bot {
    my ($class, $d) = @_;

    my $h = {};

    if ( index($d->ua, 'http://') > -1 || index($d->ua, 'https://') > -1 ) {
        bot($h);
        if ( index($d->ua, 'Mozilla/') != 0 && $d->ua =~ m!^([^/;]+)/(v?[\d.]+)! ) {
            my ($name, $version) = ($1, $2);
            name($h, $name);
            version($h, $version);
        }
        elsif ( $d->ua =~ m![\s\(]([^/\s:;]+(?:bot|crawl|crawler|spider|fetcher))/(v?[\d.]+)!i ) {
            my ($name, $version) = ($1, $2);
            name($h, $1);
            version($h, $version);
        }
        elsif ( $d->ua =~ m!([a-zA-Z0-9\-\_\.\!]+(?:bot|crawler))!i ) {
            name($h, $1);
        }
        return $h;
    }
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
