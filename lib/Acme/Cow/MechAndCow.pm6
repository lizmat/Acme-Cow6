use v6.c;

use Acme::Cow:api<perl6>;

my constant mech_and_cow = Q:to/EOC/;
{$balloon}
                {$tl}                   ,-----.
                  {$tl}                 |     |
                    {$tl}            ,--|     |-.
                         __,----|  |     | |
                       ,;::     |  `_____' |
                       `._______|    i^i   |
                                `----| |---'| .
                           ,-------._| |== ||//
                           |       |_|P`.  /'/
                           `-------' 'Y Y/'/'
                                     .==\ /_\
   ^__^                             /   /'|  `i
   ({$el}{$er})\_______                   /'   /  |   |
   (__)\       )\/\             /'    /   |   `i
    {$U} ||----w |           ___,;`----'.___L_,-'`\__
       ||     ||          i_____;----\.____i""\____\
EOC

unit class Acme::Cow::MechAndCow does Acme::Cow[mech-and-cow, over => 10];
