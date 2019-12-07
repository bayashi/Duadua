package Duadua::Parser::Util;
use strict;
use warnings;
use Exporter 'import';
our @EXPORT = qw/
    name
    bot android ios linux windows
/;

sub name {
    my ($hash, $name) = @_;
    $hash->{name} = $name;
};

sub bot {
    shift->{is_bot} = 1;
}

sub ios {
    shift->{is_ios} = 1;
}

sub android {
    shift->{is_android} = 1;
}

sub linux {
    shift->{is_linux} = 1;
}

sub windows {
    shift->{is_windows} = 1;
}

__END__

=encoding UTF-8

=head1 NAME

Duadua::Parser::Util - Parser Utility of Duadua


=head1 Export Functions

=head2 name($hash)

Set name

=head2 bot($hash)

Set bot

=head2 ios($hash)

Set iOS

=head2 android($hash)

Set Android

=head2 linux($hash)

Set Linux

=head2 windows($hash)

Set Windows


=head1 AUTHOR

Dai Okabayashi E<lt>bayashi@cpan.orgE<gt>


=head1 LICENSE

C<Duadua> is free software; you can redistribute it and/or modify it under the terms of the Artistic License 2.0. (Note that, unlike the Artistic License 1.0, version 2.0 is GPL compatible by itself, hence there is no benefit to having an Artistic 2.0 / GPL disjunction.) See the file LICENSE for details.

=cut

1;
