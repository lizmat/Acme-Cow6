use v6.d;

use Test;
use Acme::Cow::Frogs:auth<cpan:ELIZABETH>:api<perl6>;

plan 1;

is Acme::Cow::Frogs.new.say('Hi.'), Q:to/EOC/, 'do frogs say hi';
                                               _____
                                              < Hi. >
                                               -----
                                              /
                                            /
          oO)-.                       .-(Oo
         /__  _\                     /_  __\
         \  \(  |     ()~()         |  )/  /
          \__|\ |    (-___-)        | /|__/
          '  '--'    ==`-'==        '--'  '
EOC
