use strict;
use warnings;
use Test::More;

use Duadua;
use Duadua::Util;

{
    my $h = {};
    name($h, 'foo');
    is $h->{name}, 'foo';
}

{
    my $h = {};
    bot($h);
    ok $h->{is_bot};
}

{
    my $h = {};
    ios($h);
    ok $h->{is_ios};
}

{
    my $h = {};
    android($h);
    ok $h->{is_android};
}

{
    my $h = {};
    linux($h);
    ok $h->{is_linux};
}

{
    my $h = {};
    windows($h);
    ok $h->{is_windows};
}

{
    my $d = Duadua->new('Mozilla/5.0 Android');
    my $h = {};
    my $ret = Duadua::Util->set_os($d, $h);
    is $h->{is_android}, $ret->{is_android};
}

{
    my $d = Duadua->new('Mozilla/5.0 Linux');
    my $h = {};
    my $ret = Duadua::Util->set_os($d, $h);
    is $h->{is_linux}, $ret->{is_linux};
}

{
    my $d = Duadua->new('Mozilla/5.0 Win32');
    my $h = {};
    my $ret = Duadua::Util->set_os($d, $h);
    is $h->{is_windows}, $ret->{is_windows};
}

{
    my $d = Duadua->new('Mozilla/5.0 Windows');
    my $h = {};
    my $ret = Duadua::Util->set_os($d, $h);
    is $h->{is_windows}, $ret->{is_windows};
}

{
    my $d = Duadua->new('Mozilla/5.0 iPhone');
    my $h = {};
    my $ret = Duadua::Util->set_os($d, $h);
    is $h->{is_ios}, $ret->{is_ios};
}

{
    my $d = Duadua->new('Mozilla/5.0 iPad');
    my $h = {};
    my $ret = Duadua::Util->set_os($d, $h);
    is $h->{is_ios}, $ret->{is_ios};
}

{
    my $d = Duadua->new('Mozilla/5.0 iPod');
    my $h = {};
    my $ret = Duadua::Util->set_os($d, $h);
    is $h->{is_ios}, $ret->{is_ios};
}

{
    my $d = Duadua->new('Mozilla/5.0 Macintosh');
    my $h = {};
    my $ret = Duadua::Util->set_os($d, $h);
    is $h->{is_ios}, $ret->{is_ios};
}

{
    my $d = Duadua->new('Mozilla/5.0 Mac OS');
    my $h = {};
    my $ret = Duadua::Util->set_os($d, $h);
    is $h->{is_ios}, $ret->{is_ios};
}

{
    my $d = Duadua->new('Mozilla/5.0 Ordering Match');
    ok( Duadua::Util->ordering_match($d, ['Mozilla/', 'Ordering', 'Match']) );
    ok( !Duadua::Util->ordering_match($d, ['Match', 'Ordering', 'Mozilla/']) );
}

done_testing;
