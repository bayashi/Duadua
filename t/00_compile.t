use Test::AllModules;

BEGIN {
    print "$_\n" for @INC;
}

print "----------\n";
print "$_\n" for @INC;

all_ok(
    search_path => 'Duadua',
    use_ok      => 1,
    fork        => 0,
    shuffle     => 1,
);
