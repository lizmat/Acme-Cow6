use v6.d;

use Test;
use Acme::Cow:auth<cpan:ELIZABETH>:api<perl6>;

plan 3;

my $x = Acme::Cow.new;
is $x.say("Hi."), Q:to/EOC/, 'does default cow say hi';
 _____
< Hi. >
 -----
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||
EOC

is $x.think("Hi."), Q:to/EOC/, 'does default cow think hi';
 _____
( Hi. )
 -----
        o   ^__^
         o  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||
EOC

is $x.think(' Hi.'), Q:to/EOC/, 'does default cow think with space';
 ______
(  Hi. )
 ------
        o   ^__^
         o  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||
EOC
