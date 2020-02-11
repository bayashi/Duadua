use Test::More;

BEGIN {
    note "$_\n" for @INC;
}

note "----------\n";
note "$_\n" for @INC;

ok 1;

done_testing;
