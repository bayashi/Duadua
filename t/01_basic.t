use strict;
use warnings;
use Test::More;

use Duadua;

{
    my $duadua = Duadua->new;

    is $duadua->name, 'UNKNOWN', 'blank';
    ok !$duadua->is_bot;
    ok !$duadua->is_ios;
    ok !$duadua->is_android;
    ok !$duadua->is_linux;
    ok !$duadua->is_windows;
}

{
    my $duadua = Duadua->new('-');

    is $duadua->name, 'UNKNOWN', '-';
    ok !$duadua->is_bot;
    ok !$duadua->is_ios;
    ok !$duadua->is_android;
    ok !$duadua->is_linux;
    ok !$duadua->is_windows;
}

{
    my $duadua = Duadua::parse('Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)');

    is $duadua->name, 'Googlebot', 'function call';
    ok $duadua->is_bot;
    ok !$duadua->is_ios;
    ok !$duadua->is_android;
    ok !$duadua->is_linux;
    ok !$duadua->is_windows;
}

{
    my $duadua = Duadua->parse('Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)');

    is $duadua->name, 'Googlebot', 'function call';
    ok $duadua->is_bot;
    ok !$duadua->is_ios;
    ok !$duadua->is_android;
    ok !$duadua->is_linux;
    ok !$duadua->is_windows;
}

done_testing;
