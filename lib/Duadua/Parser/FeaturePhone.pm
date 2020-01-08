package Duadua::Parser::FeaturePhone;
use strict;
use warnings;
use Duadua::Util;

sub try {
    my ($class, $d) = @_;

    if ( index($d->ua, 'DoCoMo/2.0') > -1 && $d->ua =~ m!^DoCoMo/2\.0 ([^\(]+)\(!) {
        my $name = $1;
        $name =~ s/MST_v_//;
        my $h = {
            name => 'DoCoMo ' . $name,
        };

        return $h;
    }
    elsif ( index($d->ua, 'FOMA;') > -1 && index($d->ua, 'Mozilla/') > -1
            && $d->ua =~ m! \(([^;]+);FOMA;!) {
        my $h = {
            name => 'DoCoMo ' . $1,
        };

        return $h;
    }
    elsif ( index($d->ua, 'SoftBank/') > -1 ) {
        my @elements = split '/', $d->ua;
        my $h = {
            name   => 'SoftBank ' . ($elements[2] || ''),
        };

        return $h;
    }
    elsif ( index($d->ua, 'Vodafone/') > -1 ) {
        my @elements = split '/', $d->ua;
        my $h = {
            name   => 'SoftBank ' . ($elements[2] || ''),
        };

        return $h;
    }
    elsif ( index($d->ua, ';SoftBank') > -1 && index($d->ua, 'Mozilla/') > -1
            && $d->ua =~ m!\(([^;]+);SoftBank!) {
        my $h = {
            name   => 'SoftBank ' . $1,
        };

        return $h;
    }
    elsif ( index($d->ua, 'KDDI-') > -1 && $d->ua =~ m!^KDDI-([^\s]+)\s!) {
        my $h = {
            name   => 'AU KDDI ' . $1,
        };

        if ($d->opt_version) {
            my ($version) = ($d->ua =~ m! UP\.Browser/([\d.\_A-Z]+\d)!);
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
