package Duadua::Parser::HTTPClient::HTTPClient;
use strict;
use warnings;

sub try {
    my ($class, $d) = @_;

    return $class->_cli($d)
        || $class->_perl($d)
        || $class->_python($d)
        || $class->_php($d)
        || $class->_java($d)
        || $class->_golang($d)
        || $class->_ruby($d)
    ;
}

sub _cli {
    my ($class, $d) = @_;

    if ( index($d->ua, 'curl/') == 0 ) {
        my $h = {
            name => 'Curl',
        };

        if ($d->opt_version) {
            my ($version) = ($d->ua =~ m!^curl/([\d.]+)!);
            $h->{version} = $version if $version;
        }

        return $h;
    }
    elsif ( index($d->ua, 'Wget/') > -1 ) {
        my $h = {
            name => 'Wget',
        };
        if ( index($d->ua, 'linux-') > -1 ) {
            $h->{is_linux} = 1;
        }
        elsif ( index($d->ua, 'mingw32') > -1 ) {
            $h->{is_windows} = 1;
        }

        if ($d->opt_version) {
            my ($version) = ($d->ua =~ m!^Wget/([\d.]+)!);
            $h->{version} = $version if $version;
        }

        return $h;
    }
}

sub _perl {
    my ($class, $d) = @_;

    my $h;

    if ( index($d->ua, 'libwww-perl/') > -1 ) {
        $h = {
            name => 'libwww-perl',
        };

        if ($d->opt_version) {
            my ($version) = ($d->ua =~ m!libwww-perl/([\d.]+)!);
            $h->{version} = $version if $version;
        }
    }
    elsif ( index($d->ua, 'WWW-Mechanize/') > -1 ) {
        $h = {
            name => 'WWW-Mechanize',
        };

        if ($d->opt_version) {
            my ($version) = ($d->ua =~ m!^WWW-Mechanize/([\d.]+)!);
            $h->{version} = $version if $version;
        }
    }
    elsif ( index($d->ua, 'LWP::Simple/') > -1 || index($d->ua, 'lwp-trivial/') > -1 ) {
        $h = {
            name => 'LWP::Simple',
        };

        if ($d->opt_version) {
            my ($version) = ($d->ua =~ m!^lwp[^/]+/([\d.]+)!i);
            $h->{version} = $version if $version;
        }
    }
    elsif ( index($d->ua, 'Furl::HTTP/') > -1 ) {
        $h = {
            name => 'Furl',
        };

        if ($d->opt_version) {
            my ($version) = ($d->ua =~ m!^Furl::HTTP/([\d.]+)!);
            $h->{version} = $version if $version;
        }
    }

    return $h;
}

sub _python {
    my ($class, $d) = @_;

    my $h;

    if ( index($d->ua, 'Python-urllib/') > -1 ) {
        $h = {
            name => 'Python-urllib',
        };

        if ($d->opt_version) {
            my ($version) = ($d->ua =~ m!^Python-urllib/([\d.]+)!);
            $h->{version} = $version if $version;
        }
    }
    elsif ( index($d->ua, 'PycURL/') > -1 ) {
        $h = {
            name => 'PycURL',
        };

        if ($d->opt_version) {
            my ($version) = ($d->ua =~ m!^PycURL/([\d.]+)!);
            $h->{version} = $version if $version;
        }
    }
    elsif ( index($d->ua, 'HTTPie/') > -1 ) {
        $h = {
            name => 'HTTPie',
        };

        if ($d->opt_version) {
            my ($version) = ($d->ua =~ m!^HTTPie/([\d.]+)!);
            $h->{version} = $version if $version;
        }
    }

    return $h;
}

sub _php {
    my ($class, $d) = @_;

    my $h;

    if ( index($d->ua, 'GuzzleHttp/') > -1 ) {
        $h = {
            name => 'Guzzle',
        };

        if ($d->opt_version) {
            my ($version) = ($d->ua =~ m!^GuzzleHttp/([\d.]+)!);
            $h->{version} = $version if $version;
        }
    }
    elsif ( index($d->ua, 'WordPress/') == 0 || index($d->ua, 'The Incutio XML-RPC PHP Library -- WordPress/') > -1 ) {
        $h = {
            name => 'WordPress',
        };

        if ($d->opt_version) {
            my ($version) = ($d->ua =~ m!WordPress/([\d.]+)!);
            $h->{version} = $version if $version;
        }
    }
    elsif ( index($d->ua, ' PHP/') > -1 ) {
        $h = {
            name => 'PHP',
        };

        if ($d->opt_version) {
            my ($version) = ($d->ua =~ m! PHP/([\d.]+)!);
            $h->{version} = $version if $version;
        }
    }

    return $h;
}

sub _java {
    my ($class, $d) = @_;

    my $h;

    if ( index($d->ua, 'okhttp/') > -1 ) {
        $h = {
            name => 'OkHttp',
        };

        if ($d->opt_version) {
            my ($version) = ($d->ua =~ m!^okhttp/([\d.]+)!);
            $h->{version} = $version if $version;
        }
    }
    elsif ( index($d->ua, 'Jakarta Commons-HttpClient/') > -1 ) {
        $h = {
            name => 'Jakarta Commons-HttpClient',
        };

        if ($d->opt_version) {
            my ($version) = ($d->ua =~ m!^Jakarta Commons-HttpClient/([\d.]+)!);
            $h->{version} = $version if $version;
        }
    }
    elsif ( index($d->ua, 'Apache-HttpClient/') > -1 ) {
        $h = {
            name => 'Apache-HttpClient',
        };

        if ($d->opt_version) {
            my ($version) = ($d->ua =~ m!^Apache-HttpClient/([\d.]+)!);
            $h->{version} = $version if $version;
        }
    }
    elsif ( index($d->ua, 'Jersey/') > -1 ) {
        $h = {
            name => 'Jersey',
        };

        if ($d->opt_version) {
            my ($version) = ($d->ua =~ m!^Jersey/([\d.]+)!);
            $h->{version} = $version if $version;
        }
    }

    return $h;
}

sub _golang {
    my ($class, $d) = @_;

    if ( index($d->ua, 'Go-http-client/') > -1 ) {
        my $h = {
            name => 'Go-http-client',
        };

        if ($d->opt_version) {
            my ($version) = ($d->ua =~ m!^Go-http-client/([\d.]+)!);
            $h->{version} = $version if $version;
        }

        return $h;
    }
}

sub _ruby {
    my ($class, $d) = @_;

    if ($d->ua eq 'Ruby') {
        return {
            name => 'Ruby',
        };
    }
    elsif ( index($d->ua, 'Atig::Http/') > -1 ) {
        my $h = {
            name => 'Atig',
        };
        if ( index($d->ua, 'linux') > -1 ) {
            $h->{is_linux} = 1;
        }

        if ($d->opt_version) {
            my ($version) = ($d->ua =~ m!^Atig::Http/([^\s]+)!);
            $h->{version} = $version if $version;
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
