use v6.d;

use Test;
use Acme::Cow:auth<cpan:ELIZABETH>:api<perl6>;

plan 1;

is Acme::Cow.new("t/eyes.cow".IO).say("Bwahaha!"),
  Q:to/EOC/, "does it take IO::Path";
 __________
< Bwahaha! >
 ----------
    \
     \
                                   .::!!!!!!!:.
  .!!!!!:.                        .:!!!!!!!!!!!!
  ~~~~!!!!!!.                 .:!!!!!!!!!UWWW$$$ 
      :$$NWX!!:           .:!!!!!!XUWW$$$$$$$$$P 
      $$$$$##WX!:      .<!!!!UW$$$$"  $$$$$$$$# 
      $$$$$  $$$UX   :!!UW$$$$$$$$$   4$$$$$* 
      ^$$$B  $$$$     $$$$$$$$$$$$   d$$R" 
        "*$bd$$$$      '*$$$$$$$$$$$o+#" 
             """"          """"""" 
EOC
