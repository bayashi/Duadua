package Duadua::Parser::Browser::MicrosoftInternetExplorer;
use strict;
use warnings;
use Duadua::Util qw//;

sub try {
    my ($class, $d) = @_;

    return if $d->contain('http');
    return if $d->contain(' BingPreview');

    if ( $d->contain('MSIE ') && $d->contain_mozilla && $d->contain('Windows ') ) {
        my $h = {
            name       => 'Internet Explorer',
            is_windows => 1,
        };

        if ($d->opt_version) {
            my ($version) = ($d->ua =~ m! MSIE ([\d.]+); !);
            $h->{version} = $version if $version;
        }

        return $h;
    }

    if ( $d->contain('Trident/') && $d->contain(' rv:1') && $d->contain_mozilla && $d->contain('Windows ') ) {
        my $h = {
            name       => 'Internet Explorer',
            is_windows => 1,
        };

        if ($d->opt_version) {
            my ($version) = ($d->ua =~ m! rv:([\d.]+)!);
            $h->{version} = $version if $version;
        }

        return $h;
    }

    if ( $d->contain('Windows-RSS-Platform/') ) {
        my $h = {
            name => 'Windows RSS Platform',
        };

        if ($d->opt_version) {
            my ($version) = ($d->ua =~ m!^Windows-RSS-Platform/([\d.]+)!);
            $h->{version} = $version if $version;
        }

        return Duadua::Util->set_os($d, $h);
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
