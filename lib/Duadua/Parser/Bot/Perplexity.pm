package Duadua::Parser::Bot::Perplexity;
use strict;
use warnings;

sub try {
    my ($class, $d) = @_;

    if ( $d->_contain_mozilla_top && $d->_contain('+https://perplexity.ai/') ) {

        my $h = {
            name   => 'PerplexityBot',
            is_bot => 1,
        };

        if ( $d->_contain('Perplexity-User/') ) {
            $h->{name} = 'Perplexity-User';
        }

        if ($d->opt_version) {
            my ($version) = ($d->ua =~ m!Perplexity(?:-User|Bot)/([\d.]+)!);
            $h->{version} = $version if $version;
        }

        return $h;
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
