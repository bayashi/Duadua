use strict;
use warnings;
use Test::More;
use File::Basename qw//;
use File::Spec;
use YAML qw//;
use List::Util qw/shuffle/;

use Duadua;

MAIN: {
    my @args = @ARGV;

    my $root_dir = File::Spec->catfile(
        File::Basename::dirname(__FILE__),
        'testset',
    );

    opendir my $rdh, $root_dir or die "Could not open $root_dir, $!";

    my @test_yaml_cases;

    while (my $d = readdir $rdh) {
        next if $d =~ m!\.+!; 
        my $test_dir = File::Spec->catfile(
            File::Basename::dirname(__FILE__),
            'testset',
            $d,
        );
        opendir my $tdh, $test_dir or die "Could not open $test_dir, $!";
        while (my $test_yaml = readdir $tdh) {
            next unless $test_yaml =~ m!.+\.yaml$!;
            next if scalar(@args) > 0 && !(grep { $test_yaml =~ m!\Q$_!i } @args);
            push @test_yaml_cases, [$test_dir, $test_yaml];
        }
        closedir $tdh;
    }

    closedir $rdh;

#use Data::Dumper; warn 'bayadebug'. Dumper(\@test_yaml_cases). "\n"; ok 1;

    test(@{$_}) for shuffle @test_yaml_cases;
}

sub test {
    my ($dir, $test_yaml) = @_;

    my $tests = YAML::LoadFile(File::Spec->catfile($dir, $test_yaml));

    for my $t (shuffle @{$tests}) {
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

    if (exists $t->{version}) {
        my $dv = Duadua->new($t->{ua}, { version => 1 });
        is $dv->version, $t->{version}, "version, expect:$t->{version}";
    }
}

done_testing;