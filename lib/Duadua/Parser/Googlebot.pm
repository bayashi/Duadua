package Duadua::Parser::Googlebot;
use strict;
use warnings;
use Duadua::Util;

sub try {
    my ($class, $d) = @_;

    if ($d->ua eq 'google-speakr') {
        return {
            name   => 'google-speakr',
            is_bot => 1,
        };
    }

    return unless index($d->ua, 'Google') > -1;

    if ( index($d->ua, 'Googlebot-Image') > -1 ) {
        my $h = {
            name   => 'Googlebot-Image',
            is_bot => 1,
        };

        if ($d->opt('version')) {
            my ($version) = ($d->ua =~ m!^Googlebot-Image/([\d.]+)!);
            version($h, $version) if $version;
        }

        return $h;
    }

    if ( index($d->ua, 'Googlebot-News') > -1 ) {
        return {
            name   => 'Googlebot-News',
            is_bot => 1,
        };
    }

    if ( index($d->ua, 'Googlebot-Video') > -1 ) {
        my $h = {
            name   => 'Googlebot-Video',
            is_bot => 1,
        };

        if ($d->opt('version')) {
            my ($version) = ($d->ua =~ m!^Googlebot-Video/([\d.]+)!);
            version($h, $version) if $version;
        }

        return $h;
    }

    if ( index($d->ua, 'Googlebot') > -1 ) {
        my $h = _set_googlebot($d, 'Googlebot');

        if ($d->opt('version')) {
            my ($version) = ($d->ua =~ m!Googlebot/([\d.]+)!);
            version($h, $version) if $version;
        }

        return $h;
    }

    if ( index($d->ua, 'Mediapartners-Google') > -1 ) {
        return _set_googlebot($d, 'Mediapartners-Google');
    }

    if ( index($d->ua, 'AdsBot-Google-Mobile-Apps') > -1 ) {
        return {
            name   => 'AdsBot-Google-Mobile-Apps',
            is_bot => 1,
        };
    }

    if ( index($d->ua, 'AdsBot-Google-Mobile') > -1 ) {
        return _set_googlebot($d, 'AdsBot-Google-Mobile', { add_os_name => 1 });
    }

    if ( index($d->ua, 'AdsBot-Google') > -1 ) {
        return {
            name   => 'AdsBot-Google',
            is_bot => 1,
        };
    }

    if ( index($d->ua, 'FeedFetcher-Google') > -1 ) {
        return {
            name   => 'FeedFetcher-Google',
            is_bot => 1,
        };
    }

    if ( index($d->ua, 'Google-Read-Aloud') > -1 ) {
        return _set_googlebot($d, 'Google-Read-Aloud');
    }

    if ( index($d->ua, 'DuplexWeb-Google') > -1 ) {
        my $h = _set_googlebot($d, 'DuplexWeb-Google');

        if ($d->opt('version')) {
            my ($version) = ($d->ua =~ m!DuplexWeb-Google/([\d.]+)!);
            version($h, $version) if $version;
        }

        return $h;

    }

    if ( index($d->ua, 'Google Favicon') > -1 ) {
        return _set_googlebot($d, 'Google Favicon');
    }

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
    elsif ( index($d->ua, 'iPhone') > -1 ) {
        ios($h);
        $h->{name} .= ' iPhone' if $opt && $opt->{add_os_name};
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
