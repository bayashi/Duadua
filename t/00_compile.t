use Test::More;

BEGIN {
    print "$_\n" for @INC;
}

print "----------\n";
print "$_\n" for @INC;

ok 1;

done_testing;
