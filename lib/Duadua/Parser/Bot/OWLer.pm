package Duadua::Parser::Bot::OWLer;
use strict;
use warnings;

sub try {
    my ($class, $d) = @_;

    if ( $d->ua eq 'Owler (ows.eu/owler)' ) {
        return {
            name   => 'OWLer',
            is_bot => 1,
        };
    }
}

1;

__END__

=encoding UTF-8

=head1 METHODS

=head2 try

Do parse


=head1 AUTHOR

Dai Okabayashi E<lt>bayashi@cpan.orgE<gt>


=head1 LICENSE

C<Duadua> is free software; you can redistribute it and/or modify it under the terms of the Artistic License 2.0. (Note that, unlike the Artistic License 1.0, version 2.0 is GPL compatible by itself, hence there is no benefit to having an Artistic 2.0 / GPL disjunction.) See the file LICENSE for details.

=cut
