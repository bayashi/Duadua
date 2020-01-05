use strict;
use warnings;
use Test::More;

use Duadua;

{
    my $d = Duadua->new;

    is $d->name, 'UNKNOWN', 'blank';
    ok !$d->is_bot;
    ok !$d->is_ios;
    ok !$d->is_android;
    ok !$d->is_linux;
    ok !$d->is_windows;
}

{
    my $d = Duadua->new('-');

    is $d->name, 'UNKNOWN', '-';
    ok !$d->is_bot;
    ok !$d->is_ios;
    ok !$d->is_android;
    ok !$d->is_linux;
    ok !$d->is_windows;
}

{
    my $d = Duadua->new('~');

    is $d->name, 'UNKNOWN', '~';
    ok !$d->is_bot;
    ok !$d->is_ios;
    ok !$d->is_android;
    ok !$d->is_linux;
    ok !$d->is_windows;
}

{
    local $ENV{'HTTP_USER_AGENT'} = 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)';
    my $d = Duadua->new;

    is $d->name, 'Googlebot', 'from ENV';
    ok $d->is_bot;
    ok !$d->is_ios;
    ok !$d->is_android;
    ok !$d->is_linux;
    ok !$d->is_windows;
}

{
    my $d = Duadua::parse('Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)');

    is $d->name, 'Googlebot', 'function call';
    ok $d->is_bot;
    ok !$d->is_ios;
    ok !$d->is_android;
    ok !$d->is_linux;
    ok !$d->is_windows;
}

{
    my $d = Duadua->parse('Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)');

    is $d->name, 'Googlebot', 'method call';
    ok $d->is_bot;
    ok !$d->is_ios;
    ok !$d->is_android;
    ok !$d->is_linux;
    ok !$d->is_windows;
}

done_testing;
