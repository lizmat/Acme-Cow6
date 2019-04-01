use v6.d;

use Test;
use Acme::Cow:auth<cpan:ELIZABETH>:api<perl6>;

plan 3;

is Acme::Cow.new.balloon(["Hi."]), Q:to/EOB/, "balloon says ok";
 _____
< Hi. >
 -----
EOB

is Acme::Cow.new(:6over).balloon([" Hi."],'think'),
  Q:to/EOB/, "balloon thinks ok";
       ______
      (  Hi. )
       ------
EOB

is Acme::Cow.new(:!fill).balloon( [
"A limerick packs laughs anatomical\n",
"Into space that is quite economical.\n",
"\tBut the good ones I've seen\n",
"\tSo seldom are clean\n",
"And the clean ones so seldom are comical.\n"
] ), Q:to/EOB/, 'is complete text with tabs and non-filling ok'
 ___________________________________________
/ A limerick packs laughs anatomical        \
| Into space that is quite economical.      |
|         But the good ones I've seen       |
|         So seldom are clean               |
\ And the clean ones so seldom are comical. /
 -------------------------------------------
EOB
