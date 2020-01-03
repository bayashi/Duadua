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
        return {
            name => 'Curl',
        };
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
        return $h;
    }
}

sub _perl {
    my ($class, $d) = @_;

    if ( index($d->ua, 'libwww-perl/') > -1 ) {
        return {
            name => 'libwww-perl',
        };
    }
    elsif ( index($d->ua, 'WWW-Mechanize/') == 0 ) {
        return {
            name => 'WWW-Mechanize',
        };
    }
    elsif ( index($d->ua, 'LWP::Simple/') == 0 || index($d->ua, 'lwp-trivial') == 0 ) {
        return {
            name => 'LWP::Simple',
        };
    }
    elsif ( index($d->ua, 'Furl::HTTP/') == 0 ) {
        return {
            name => 'Furl',
        };
    }
}

sub _python {
    my ($class, $d) = @_;

    if ( index($d->ua, 'Python-urllib/') == 0 ) {
        return {
            name => 'Python-urllib',
        };
    }
    elsif ( index($d->ua, 'PycURL/') == 0 ) {
        return {
            name => 'PycURL',
        };
    }
    elsif ( index($d->ua, 'HTTPie/') == 0 ) {
        return {
            name => 'HTTPie',
        };
    }
}

sub _php {
    my ($class, $d) = @_;

    if ( index($d->ua, 'GuzzleHttp/') == 0 ) {
        return {
            name => 'Guzzle',
        };
    }
    elsif ( index($d->ua, 'WordPress/') == 0 || index($d->ua, 'The Incutio XML-RPC PHP Library -- WordPress/') == 0 ) {
        return {
            name => 'WordPress',
        };
    }
    elsif ( index($d->ua, ' PHP/') > -1 ) {
        return {
            name => 'PHP',
        };
    }
}

sub _java {
    my ($class, $d) = @_;

    if ( index($d->ua, 'okhttp/') == 0 ) {
        return {
            name => 'OkHttp',
        };
    }
    elsif ( index($d->ua, 'Jakarta Commons-HttpClient/') == 0 ) {
        return {
            name => 'Jakarta Commons-HttpClient',
        };
    }
    elsif ( index($d->ua, 'Apache-HttpClient/') == 0 ) {
        return {
            name => 'Apache-HttpClient',
        };
    }
}

sub _golang {
    my ($class, $d) = @_;

    if ( index($d->ua, 'Go-http-client/') == 0 ) {
        return {
            name => 'Go-http-client',
        };
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
