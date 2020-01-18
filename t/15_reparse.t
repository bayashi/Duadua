use strict;
use warnings;
use Test::More;

use Duadua;

{
    my $d = Duadua->new('Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)', { version => 1 });
    is $d->name, 'Googlebot', 'reset';
    ok !$d->is_windows;
    is $d->version, '2.1';

    my $result = $d->reparse('Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:71.0) Gecko/20100101 Firefox/71.0');
    is $result->name, 'Mozilla Firefox', 'reset';
    ok !$result->is_bot;
    ok !$result->is_ios;
    ok !$result->is_android;
    ok !$result->is_linux;
    ok $result->is_windows;
    is $result->version, '71.0';
}

done_testing;
