package Duadua::Parser::Googlebot;
use strict;
use warnings;
use Duadua::Parser::Util;

sub try {
    my ($class, $duadua) = @_;

    if ($duadua->ua eq 'google-speakr') {
        return {
            name   => 'google-speakr',
            is_bot => 1,
        };
    }

    return unless index($duadua->ua, 'Google') > -1;

    ####
    #
    # Googlebot
    # https://support.google.com/webmasters/answer/1061943?hl=en
    #
    ####

    # Googlebot-Image/1.0
    if ( index($duadua->ua, 'Googlebot-Image') > -1 ) {
        return {
            name   => 'Googlebot-Image',
            is_bot => 1,
        };
    }

    # Googlebot-Image/1.0
    if ( index($duadua->ua, 'Googlebot-News') > -1 ) {
        return {
            name   => 'Googlebot-News',
            is_bot => 1,
        };
    }

    # Googlebot-Video/1.0
    if ( index($duadua->ua, 'Googlebot-Video') > -1 ) {
        return {
            name   => 'Googlebot-Video',
            is_bot => 1,
        };
    }

    # Googlebot/2.1 (+http://www.google.com/bot.html)
    if ( index($duadua->ua, 'Googlebot') > -1 ) {
        return _set_googlebot($duadua, 'Googlebot');
    }

    ####
    #
    # Google
    #
    ####

    # Mediapartners-Google
    if ( index($duadua->ua, 'Mediapartners-Google') > -1 ) {
        return _set_googlebot($duadua, 'Mediapartners-Google');
    }

    # AdsBot-Google-Mobile-Apps
    if ( index($duadua->ua, 'AdsBot-Google-Mobile-Apps') > -1 ) {
        return {
            name   => 'AdsBot-Google-Mobile-Apps',
            is_bot => 1,
        };
    }

    # Mozilla/5.0 (Linux; Android 5.0; SM-G920A) AppleWebKit (KHTML, like Gecko) Chrome Mobile Safari (compatible; AdsBot-Google-Mobile; +http://www.google.com/mobile/adsbot.html)
    if ( index($duadua->ua, 'AdsBot-Google-Mobile') > -1 ) {
        return _set_googlebot($duadua, 'AdsBot-Google-Mobile', { add_os_name => 1 });
    }

    # AdsBot-Google (+http://www.google.com/adsbot.html)
    if ( index($duadua->ua, 'AdsBot-Google') > -1 ) {
        return {
            name   => 'AdsBot-Google',
            is_bot => 1,
        };
    }

    # FeedFetcher-Google; (+http://www.google.com/feedfetcher.html)
    if ( index($duadua->ua, 'FeedFetcher-Google') > -1 ) {
        return {
            name   => 'FeedFetcher-Google',
            is_bot => 1,
        };
    }

    # Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.118 Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)
    if ( index($duadua->ua, 'Google-Read-Aloud') > -1 ) {
        return _set_googlebot($duadua, 'Google-Read-Aloud');
    }

    # Mozilla/5.0 (Linux; Android 8.0; Pixel 2 Build/OPD3.170816.012; DuplexWeb-Google/1.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.131 Mobile Safari/537.36
    if ( index($duadua->ua, 'DuplexWeb-Google') > -1 ) {
        return _set_googlebot($duadua, 'DuplexWeb-Google');
    }

    # Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko)  Chrome/49.0.2623.75 Safari/537.36 Google Favicon
    if ( index($duadua->ua, 'Google Favicon') > -1 ) {
        return _set_googlebot($duadua, 'Google Favicon');
    }

    # APIs-Google (+https://developers.google.com/webmasters/APIs-Google.html)
    if ( index($duadua->ua, 'APIs-Google') > -1 ) {
        return {
            name   => 'APIs-Google',
            is_bot => 1,
        };
    }
}

sub _set_googlebot {
    my ($duadua, $name, $opt) = @_;

    my $h = { name => $name };
    bot($h);

    if ( index($duadua->ua, 'Android') > -1 ) {
        android($h);
        linux($h); # Android is Linux also.
        $h->{name} .= ' Android' if $opt && $opt->{add_os_name};
    }
    elsif ( index($duadua->ua, 'Linux') > -1 ) {
        linux($h);
        $h->{name} .= ' Linux' if $opt && $opt->{add_os_name};
    }
    elsif ( index($duadua->ua, 'Win32') > -1 || index($duadua->ua, 'Windows') > -1 ) {
        windows($h);
        $h->{name} .= ' Windows' if $opt && $opt->{add_os_name};
    }
    elsif ( index($duadua->ua, 'iPhone') > -1 ) {
        ios($h);
        $h->{name} .= ' iPhone' if $opt && $opt->{add_os_name};
    }
    elsif ( index($duadua->ua, 'iPad') > -1 || index($duadua->ua, 'iPod') > -1 ) {
        ios($h);
        $h->{name} .= ' iOS' if $opt && $opt->{add_os_name};
    }
    elsif ( index($duadua->ua, 'Macintosh') > -1 || index($duadua->ua, 'Mac OS') > -1 ) {
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
