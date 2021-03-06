use v6.d;

use Acme::Cow:api<perl6>;

my constant stegosaurus = Q:to/EOC/;
{$balloon}
                {$tr}                  .       .
              {$tr}                   / `.   .' " 
            {$tr}             .---.  <    > <    >  .---.
                         |    \  \ - ~ ~ - /  /    |
         _____          ..-~             ~-..-~
        |     |   \~~~\.'                    `./~~~/
       ---------   \__/                        \__/
      .'  O    \     /               /       \  " 
     (_____,    `._.'               |         \}  \/~~~/
      `----.          /       \}     |        /    \__/
            `-.      |       /      |       /      `. ,~~|
                ~-.__|      /_ - ~ ^|      /- _      `..-'   
                     |     /        |     /     ~-.     `-. _  _  _
                     |_____|        |_____|         ~ - . _ _ _ _ _>
EOC

unit class Acme::Cow::Stegosaurus does Acme::Cow[stegosaurus, over => 20];
