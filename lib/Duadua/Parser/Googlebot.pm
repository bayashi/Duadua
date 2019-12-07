package Duadua::Parser::Googlebot;
use strict;
use warnings;
use Duadua::Parser::Util;

sub try {
    my ($class, $d) = @_;

    if ($d->ua eq 'google-speakr') {
        return {
            name   => 'google-speakr',
            is_bot => 1,
        };
    }

    return unless index($d->ua, 'Google') > -1;

    ####
    #
    # Googlebot
    # https://support.google.com/webmasters/answer/1061943?hl=en
    #
    ####

    # Googlebot-Image/1.0
    if ( index($d->ua, 'Googlebot-Image') > -1 ) {
        return {
            name   => 'Googlebot-Image',
            is_bot => 1,
        };
    }

    # Googlebot-Image/1.0
    if ( index($d->ua, 'Googlebot-News') > -1 ) {
        return {
            name   => 'Googlebot-News',
            is_bot => 1,
        };
    }

    # Googlebot-Video/1.0
    if ( index($d->ua, 'Googlebot-Video') > -1 ) {
        return {
            name   => 'Googlebot-Video',
            is_bot => 1,
        };
    }

    # Googlebot/2.1 (+http://www.google.com/bot.html)
    if ( index($d->ua, 'Googlebot') > -1 ) {
        return _set_googlebot($d, 'Googlebot');
    }

    ####
    #
    # Google
    #
    ####

    # Mediapartners-Google
    if ( index($d->ua, 'Mediapartners-Google') > -1 ) {
        return _set_googlebot($d, 'Mediapartners-Google');
    }

    # AdsBot-Google-Mobile-Apps
    if ( index($d->ua, 'AdsBot-Google-Mobile-Apps') > -1 ) {
        return {
            name   => 'AdsBot-Google-Mobile-Apps',
            is_bot => 1,
        };
    }

    # Mozilla/5.0 (Linux; Android 5.0; SM-G920A) AppleWebKit (KHTML, like Gecko) Chrome Mobile Safari (compatible; AdsBot-Google-Mobile; +http://www.google.com/mobile/adsbot.html)
    if ( index($d->ua, 'AdsBot-Google-Mobile') > -1 ) {
        return _set_googlebot($d, 'AdsBot-Google-Mobile', { add_os_name => 1 });
    }

    # AdsBot-Google (+http://www.google.com/adsbot.html)
    if ( index($d->ua, 'AdsBot-Google') > -1 ) {
        return {
            name   => 'AdsBot-Google',
            is_bot => 1,
        };
    }

    # FeedFetcher-Google; (+http://www.google.com/feedfetcher.html)
    if ( index($d->ua, 'FeedFetcher-Google') > -1 ) {
        return {
            name   => 'FeedFetcher-Google',
            is_bot => 1,
        };
    }

    # Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.118 Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)
    if ( index($d->ua, 'Google-Read-Aloud') > -1 ) {
        return _set_googlebot($d, 'Google-Read-Aloud');
    }

    # Mozilla/5.0 (Linux; Android 8.0; Pixel 2 Build/OPD3.170816.012; DuplexWeb-Google/1.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.131 Mobile Safari/537.36
    if ( index($d->ua, 'DuplexWeb-Google') > -1 ) {
        return _set_googlebot($d, 'DuplexWeb-Google');
    }

    # Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko)  Chrome/49.0.2623.75 Safari/537.36 Google Favicon
    if ( index($d->ua, 'Google Favicon') > -1 ) {
        return _set_googlebot($d, 'Google Favicon');
    }

    # APIs-Google (+https://developers.google.com/webmasters/APIs-Google.html)
    if ( index($d->ua, 'APIs-Google') > -1 ) {
        return {
            name   => 'APIs-Google',
            is_bot => 1,
        };
    }
}

sub _set_googlebot {
    my ($d, $name, $opt) = @_;

    my $h = { name => $name };
    bot($h);

    if ( index($d->ua, 'Android') > -1 ) {
        android($h);
        linux($h); # Android is Linux also.
        $h->{name} .= ' Android' if $opt && $opt->{add_os_name};
    }
    elsif ( index($d->ua, 'Linux') > -1 ) {
        linux($h);
        $h->{name} .= ' Linux' if $opt && $opt->{add_os_name};
    }
    elsif ( index($d->ua, 'Win32') > -1 || index($d->ua, 'Windows') > -1 ) {
        windows($h);
        $h->{name} .= ' Windows' if $opt && $opt->{add_os_name};
    }
    elsif ( index($d->ua, 'iPhone') > -1 ) {
        ios($h);
        $h->{name} .= ' iPhone' if $opt && $opt->{add_os_name};
    }
    elsif ( index($d->ua, 'iPad') > -1 || index($d->ua, 'iPod') > -1 ) {
        ios($h);
        $h->{name} .= ' iOS' if $opt && $opt->{add_os_name};
    }
    elsif ( index($d->ua, 'Macintosh') > -1 || index($d->ua, 'Mac OS') > -1 ) {
        ios($h);
        $h->{name} .= ' Mac OS' if $opt && $opt->{add_os_name};
    }

    return $h;
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
