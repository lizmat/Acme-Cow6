use v6.d;

use Acme::Cow:api<perl6>;

my constant tux-being-stabbed = Q:to/EOC/;
{$balloon}
             {$tl}            ,        ,
               {$tl}         /(        )`
                 {$tl}       \ \___   / |
                        /- _  `-/  '
                       (/\/ \ \   /\
                       / /   | `    \
                       O O   ) /    |
                       `-^--'`<     '
     .--.             (_.)  _  )   /
    |o_o |             `.___/`    /
    |:_/ |              `-----' /
   //<- \ \----.     __ / __   \
  (|  <- | )---|====O)))==) \) /====
 /'\ <- _/`\---'    `--' `.__,' \
 \___)=(___/            |        |
                         \       /
                    ______( (_  / \______
                  ,'  ,-----'   |        \
                  `--\{__________)        \/
EOC

unit class Acme::Cow::TuxStab does Acme::Cow[tux-being-stabbed, over => 8];
