use strict;
use warnings;
use Benchmark qw/cmpthese/;

use Duadua;
use Woothee;
use HTTP::DetectUserAgent;
use HTTP::BrowserDetect;

# Don't care about exact 'name' string.
# This is just parsing benchmark.

my @UA_LIST = (
    'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; InfoPath.1)',
    'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322)',
    'Mozilla/5.0 (Windows NT 6.1; Trident/7.0; BOIE9;JAJP; rv:11.0) like Gecko',
    'Mozilla/5.0 (Windows NT 6.3; Win64; x64; Trident/7.0; Touch; rv:11.0) like Gecko',
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64; ServiceUI 11) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36 Edge/16.16299',
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.48 Safari/537.36 Edg/74.1.96.24',
    'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.79 Safari/537.36',
    'Mozilla/5.0 (Linux; U; Android-4.0.3; en-us; Galaxy Nexus Build/IML74K) AppleWebKit/535.7 (KHTML, like Gecko) CrMo/16.0.912.75 Mobile Safari/535.7',
    'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:71.0) Gecko/20100101 Firefox/71.0',
    'Mozilla/5.0 (iPhone; CPU iPhone OS 13_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) FxiOS/20.2 Mobile/15E148 Safari/605.1.15',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/601.3.9 (KHTML, like Gecko) Version/9.0.2 Safari/537.86.3',
    'Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.96 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)',
    'Twitterbot/1.0',
    'Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)',
    'curl/7.19.7 (x86_64-redhat-linux-gnu) libcurl/7.19.7 NSS/3.27.1 zlib/1.2.3 libidn/1.18 libssh2/1.4.2',
);

cmpthese(-1, {
    Duadua  => \&_duadua,
    Woothee => \&_woothee,
    'HTTP::DetectUserAgent' => \&_detect_user_agent,
    'HTTP::BrowserDetect'   => \&_browser_detect,
});

sub _duadua {
    for my $ua (@UA_LIST) {
        my $d = Duadua->parse($ua);
        my $name = $d->name;
    }
}

sub _woothee {
    for my $ua (@UA_LIST) {
        my $w = Woothee->parse($ua);
        my $name = $w->{name};
    }
}

sub _detect_user_agent {
    for my $ua (@UA_LIST) {
        my $h = HTTP::DetectUserAgent->new($ua);
        my $name = $h->name;
    }
}

sub _browser_detect {
    for my $ua (@UA_LIST) {
        my $h = HTTP::BrowserDetect->new($ua);
        my $name = $h->browser;
    }
}

=pod

                        Rate HTTP::BrowserDetect Woothee HTTP::DetectUserAgent Duadua
HTTP::BrowserDetect   1141/s                  --    -22%                  -36%   -42%
Woothee               1464/s                 28%      --                  -18%   -25%
HTTP::DetectUserAgent 1777/s                 56%     21%                    --   -10%
Duadua                1964/s                 72%     34%                   11%     --

=cut
