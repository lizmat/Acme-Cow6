use v6.d;

use Acme::Cow:api<perl6>;

my constant dragon-and-cow = Q:to/EOC/;
{$balloon}
                 {$tl}                          ^    /^
                    {$tl}                      / \  // \
                       {$tl}     |\___/|      /   \//  .\
                          {$tl}  /O  O  \__  /    //  | \ \           *----*
                            /     /  \/_/    //   |  \  \          \   |
                            @___@`    \/_   //    |   \   \         \/\ \
                           0/0/|       \/_ //     |    \    \         \  \
                       0/0/0/0/|        \///      |     \     \       |  |
                    0/0/0/0/0/_|_ /   (  //       |      \     _\     |  /
                 0/0/0/0/0/0/`/,_ _ _/  ) ; -.    |    _ _\.-~       /   /
                             ,-\}        _      *-.|.-~-.           .~    ~
            \     \__/        `/\      /                 ~-. _ .-~      /
             \____({$el}{$er})           *.   \}            \{                   /
             (    (--)          .----~-.\        \-`                 .~
             //__\\  \__ Ack!   ///.----..<        \             _ -~
            //    \\               ///-._ _ _ _ _ _ _\{^ - - - - ~
EOC

unit class Acme::Cow::DragonAndCow Acme::Cow[dragon-and-cow];
