use strict;
use warnings;
use Module::Build;

my %win_build_requires = ();

if ($^O eq 'MSWin32') {
    %win_build_requires = (
        'Win32' => 0
    );
}

my $builder = Module::Build->new(
    module_name         => 'Duadua',
    license             => 'artistic_2',
    dist_author         => 'Dai Okabayashi <bayashi@cpan.org>',
    dist_version_from   => 'lib/Duadua.pm',
    configure_requires  => {
        'Module::Build' => 0.40,
    },
    test_requires => {
        'File::Basename' => 0,
        'YAML' => '1.15',
        'List::Util' => 0,
        'Test::More' => '1.3',
        'Test::AllModules' => '0.17',
        'Capture::Tiny' => 0,
        %win_build_requires,
        # xt
        'Software::License' => 0,
        'Test::Perl::Critic' => 0,
        'Test::Pod::Coverage' => 0,
        'Test::Pod' => 0,
        'Test::NoTabs' => 0,
        'Test::Vars' => 0,
        'Test::File::Find::Rule' => 0,
    },
    requires => {
        'perl' => '5.008005',
        'strict' => 0,
        'warnings' => 0,
        'Module::Pluggable::Object' => 0,
        'Pod::Usage' => 0,
        'Getopt::Long' => 0,
        'JSON' => 0,
    },
    add_to_cleanup      => [ 'Duadua-*' ],
    script_files        => [ 'script/duadua' ],
    add_to_cleanup      => [ 'Duadua-*' ],
    meta_merge     => {
      resources => {
        repository  => 'http://github.com/bayashi/Duadua',
        bugtracker  => 'http://github.com/bayashi/Duadua/issues',
      }
    },
    recursive_test_files => 1,
    test_files => (-d '.git' || $ENV{RELEASE_TESTING}) ? ['t/', 'xt/'] : ['t/'],
    create_license => 1, # https://metacpan.org/pod/Software::License
);

$builder->create_build_script();
