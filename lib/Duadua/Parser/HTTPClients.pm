package Duadua::Parser::HTTPClients;
use strict;
use warnings;
use Duadua::Util;

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

        if ($d->opt('version')) {
            my ($version) = ($d->ua =~ m!^curl/([\d.]+)!);
            version($h, $version) if $version;
        }

        return $h;
    }
    elsif ( index($d->ua, 'Wget/') == 0 ) {
        my $h = {
            name => 'Wget',
        };
        if ( index($d->ua, 'linux-') > -1 ) {
            linux($h);
        }
        elsif ( index($d->ua, 'mingw32') > -1 ) {
            windows($h);
        }

        if ($d->opt('version')) {
            my ($version) = ($d->ua =~ m!^Wget/([\d.]+)!);
            version($h, $version) if $version;
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

        if ($d->opt('version')) {
            my ($version) = ($d->ua =~ m!libwww-perl/([\d.]+)!);
            version($h, $version) if $version;
        }
    }
    elsif ( index($d->ua, 'WWW-Mechanize/') == 0 ) {
        $h = {
            name => 'WWW-Mechanize',
        };

        if ($d->opt('version')) {
            my ($version) = ($d->ua =~ m!^WWW-Mechanize/([\d.]+)!);
            version($h, $version) if $version;
        }
    }
    elsif ( index($d->ua, 'LWP::Simple/') == 0 || index($d->ua, 'lwp-trivial/') == 0 ) {
        $h = {
            name => 'LWP::Simple',
        };

        if ($d->opt('version')) {
            my ($version) = ($d->ua =~ m!^lwp[^/]+/([\d.]+)!i);
            version($h, $version) if $version;
        }
    }
    elsif ( index($d->ua, 'Furl::HTTP/') == 0 ) {
        $h = {
            name => 'Furl',
        };

        if ($d->opt('version')) {
            my ($version) = ($d->ua =~ m!^Furl::HTTP/([\d.]+)!);
            version($h, $version) if $version;
        }
    }

    return $h;
}

sub _python {
    my ($class, $d) = @_;

    my $h;

    if ( index($d->ua, 'Python-urllib/') == 0 ) {
        $h = {
            name => 'Python-urllib',
        };

        if ($d->opt('version')) {
            my ($version) = ($d->ua =~ m!^Python-urllib/([\d.]+)!);
            version($h, $version) if $version;
        }
    }
    elsif ( index($d->ua, 'PycURL/') == 0 ) {
        $h = {
            name => 'PycURL',
        };

        if ($d->opt('version')) {
            my ($version) = ($d->ua =~ m!^PycURL/([\d.]+)!);
            version($h, $version) if $version;
        }
    }
    elsif ( index($d->ua, 'HTTPie/') == 0 ) {
        $h = {
            name => 'HTTPie',
        };

        if ($d->opt('version')) {
            my ($version) = ($d->ua =~ m!^HTTPie/([\d.]+)!);
            version($h, $version) if $version;
        }
    }

    return $h;
}

sub _php {
    my ($class, $d) = @_;

    my $h;

    if ( index($d->ua, 'GuzzleHttp/') == 0 ) {
        $h = {
            name => 'Guzzle',
        };

        if ($d->opt('version')) {
            my ($version) = ($d->ua =~ m!^GuzzleHttp/([\d.]+)!);
            version($h, $version) if $version;
        }
    }
    elsif ( index($d->ua, 'WordPress/') == 0 || index($d->ua, 'The Incutio XML-RPC PHP Library -- WordPress/') == 0 ) {
        $h = {
            name => 'WordPress',
        };

        if ($d->opt('version')) {
            my ($version) = ($d->ua =~ m!WordPress/([\d.]+)!);
            version($h, $version) if $version;
        }
    }
    elsif ( index($d->ua, ' PHP/') > -1 ) {
        $h = {
            name => 'PHP',
        };

        if ($d->opt('version')) {
            my ($version) = ($d->ua =~ m! PHP/([\d.]+)!);
            version($h, $version) if $version;
        }
    }

    return $h;
}

sub _java {
    my ($class, $d) = @_;

    my $h;

    if ( index($d->ua, 'okhttp/') == 0 ) {
        $h = {
            name => 'OkHttp',
        };

        if ($d->opt('version')) {
            my ($version) = ($d->ua =~ m!^okhttp/([\d.]+)!);
            version($h, $version) if $version;
        }
    }
    elsif ( index($d->ua, 'Jakarta Commons-HttpClient/') == 0 ) {
        $h = {
            name => 'Jakarta Commons-HttpClient',
        };

        if ($d->opt('version')) {
            my ($version) = ($d->ua =~ m!^Jakarta Commons-HttpClient/([\d.]+)!);
            version($h, $version) if $version;
        }
    }
    elsif ( index($d->ua, 'Apache-HttpClient/') == 0 ) {
        $h = {
            name => 'Apache-HttpClient',
        };

        if ($d->opt('version')) {
            my ($version) = ($d->ua =~ m!^Apache-HttpClient/([\d.]+)!);
            version($h, $version) if $version;
        }
    }

    return $h;
}

sub _golang {
    my ($class, $d) = @_;

    if ( index($d->ua, 'Go-http-client/') == 0 ) {
        my $h = {
            name => 'Go-http-client',
        };

        if ($d->opt('version')) {
            my ($version) = ($d->ua =~ m!^Go-http-client/([\d.]+)!);
            version($h, $version) if $version;
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
    elsif ( index($d->ua, 'Atig::Http/') == 0 ) {
        my $h = {
            name => 'Atig',
        };
        if ( index($d->ua, 'linux') > -1 ) {
            linux($h);
        }

        if ($d->opt('version')) {
            my ($version) = ($d->ua =~ m!^Atig::Http/([^\s]+)!);
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
