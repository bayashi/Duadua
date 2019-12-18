use strict;
use warnings;
use Test::More;
use File::Basename qw//;
use File::Spec;
use YAML qw//;

use Duadua;

MAIN: {
    my $dir = File::Spec->catfile(
        File::Basename::dirname(__FILE__),
        'testset',
    );

    opendir my $dh, $dir or die "Could not open $dir, $!";

    while (my $test_yaml = readdir $dh) {
        next unless $test_yaml =~ m!.+\.yaml$!;
        test($dir, $test_yaml);
    }

    closedir $dh;
}

sub test {
    my ($dir, $test_yaml) = @_;

    my $tests = YAML::LoadFile(File::Spec->catfile($dir, $test_yaml));

    for my $t (@{$tests}) {
        for my $k (keys %{$t}) {
            next unless $k =~ m!^is_!;
            $t->{$k} = $t->{$k} eq 'true' ? 1 : 0;
        }

        subtest $test_yaml => sub {
            _test($t);
        };
    }
}

sub _test {
    my ($t) = @_;

    my $d = Duadua->new($t->{ua});

    is $t->{ua}, $d->ua, $t->{ua};

    for my $i (qw/
        name
        is_bot
        is_ios
        is_android
        is_linux
        is_windows
    /) {
        is $d->$i, $t->{$i}, "$i, expect:$t->{$i}";
    }
}

done_testing;