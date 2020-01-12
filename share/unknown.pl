use strict;
use warnings;

use Duadua;

while (my $ua = <STDIN>) {
    chomp $ua;

    $ua =~ s!^"!!;
    $ua =~ s!"$!!;

    next if $ua eq '' || $ua eq '-' || $ua eq '~';

    my $d = Duadua->new($ua);

    print "$ua\n" if $d->name eq 'UNKNOWN';
}
