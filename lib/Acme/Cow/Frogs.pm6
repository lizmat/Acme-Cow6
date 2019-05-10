use v6.d;

use Acme::Cow:api<perl6>;

my constant frogs = Q:to/EOC/;
{$balloon}
                                              {$tr}
                                            {$tr}
          oO)-.                       .-(Oo
         /__  _\                     /_  __\
         \  \(  |     ()~()         |  )/  /
          \__|\ |    (-___-)        | /|__/
          '  '--'    ==`-'==        '--'  '
EOC

unit class Acme::Cow::Frogs does Acme::Cow[frogs, over => 46];
