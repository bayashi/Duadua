package Duadua::Parser::Bot::GoogleRead;
use strict;
use warnings;

sub try {
    my ($class, $d) = @_;

    if ($d->ua eq 'google-speakr') {
        return {
            name   => 'google-speakr',
            is_bot => 1,
        };
    }

    if ( index($d->ua, 'Google-Read-Aloud') > -1 ) {
        return _set_googlebot($d, 'Google-Read-Aloud');
    }
}

sub _set_googlebot {
    my ($d, $name, $opt) = @_;

    my $h = {
        name   => $name,
        is_bot => 1,
    };

    if ( index($d->ua, 'Android') > -1 ) {
        $h->{is_android} = 1;
        $h->{is_linux}   = 1;
        $h->{name} .= ' Android' if $opt && $opt->{add_os_name};
    }
    elsif ( index($d->ua, 'Linux') > -1 ) {
        $h->{is_linux} = 1;
        $h->{name} .= ' Linux' if $opt && $opt->{add_os_name};
    }
    elsif ( index($d->ua, 'iPhone') > -1 ) {
        $h->{is_ios} = 1;
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
