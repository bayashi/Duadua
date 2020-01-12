package Duadua::Parser::MicrosoftEdge;
use strict;
use warnings;

sub try {
    my ($class, $d) = @_;

    return if index($d->ua, 'Edg') == -1;

    if ( ( index($d->ua, 'Edge/') > -1 || index($d->ua, 'Edg/') > -1 )
            && index($d->ua, 'Windows') > -1 && index($d->ua, 'Mozilla/') > -1 ) {
        my $h = {
            name   => 'Microsoft Edge',
            is_windows => 1,
        };

        if ($d->opt_version) {
            my ($version) = ($d->ua =~ m! Edge?/([\d.]+)!);
            $h->{version} = $version if $version;
        }

        return $h;
    }
    elsif ( index($d->ua, 'EdgiOS/') > -1 && index($d->ua, 'Mozilla/') > -1 ) {
        my $h = {
            name   => 'Microsoft Edge',
            is_ios => 1,
        };

        if ($d->opt_version) {
            my ($version) = ($d->ua =~ m! EdgiOS/([\d.]+)!);
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
