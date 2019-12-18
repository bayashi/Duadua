package Duadua::Parser::AppleSafari;
use strict;
use warnings;
use Duadua::Parser::Util;

sub try {
    my ($class, $d) = @_;

    if ( index($d->ua, 'Mozilla/5.0 (Mac') > -1 && index($d->ua, 'Safari/') > -1 ) {
        return {
            name   => 'Apple Safari',
            is_ios => 1,
        };
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
