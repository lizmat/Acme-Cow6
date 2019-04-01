NAME
====

Acme::Cow - Talking barnyard animals (or ASCII art in general)

SYNOPSIS
========

```perl6
  use Acme::Cow:api<perl6>;

  my Acme::Cow $cow .= new;
  $cow.say("Moo!");

  my $sheep = Acme::Cow::Frogs.new(over => 20);    # Derived from Acme::Cow
  $sheep.think("Yeah, but you're taking the universe out of context.").note;

  my $duck = Acme::Cow.new("duck.cow".IO, :!fill);
  $socket.print($duck.say(qx/figlet quack/));
```

DESCRIPTION
===========

Acme::Cow is the logical evolution of the old cowsay program. Cows are derived from a base class (Acme::Cow) or from external files.

Cows can be made to say or think many things, optionally filling and justifying their text out to a given margin.

Cows are nothing without the ability to print them, or sling them as strings, or what not.

METHODS
=======

new
---

    my $cow = Acme::Cow.new(
      $graphic,     # string or IO::Path object, optional
      over => 0,    # move text so many spaces to right, optional
      wrap => 40,   # character positions to wrap text to, optional
      fill => True, # whether to fill the balloon with text or not, optional
      el   => 'o',  # left eye, optional
      er   => 'o',  # right eye, optional
      U    => '  ', # tongue, optional
    );

Create a new `Acme::Cow` object.

When called in sink context, will call method `say` on it, which will read the text from `STDIN` and output the graphic on `STDOUT`.

over
----

    $cow.over = 20;  # move text over 20 positions
    say "Moving text {$cow.over} to the right";

Specify (or retrieve) how far to the right (in spaces) the text balloon should be shoved. Defaults to 0.

wrap
----

    $cow.wrap = 45;  # wrap text within 45 positions
    say "Wrapping text at {$cow.wrap} positions";

Specify (or retrieve) the column at which text inside the balloon should be wrapped. This number is relative to the balloon, not absolute screen position. Defaults to 40.

This value is ignored if `fill` is False.

fill
----

    $cow.fill = False;
    say "Will {"NOT " unless $cow.fill} fill the text balloon";

Specify (or retrieve) whether text will be filled out inside the balloon or not. Defaults to True.

el
--

    $cow.el = 'x';
    say "The left eye is {$cow.el}";

Specify (or retrieve) the character to be used for the left eye in the graphic. Defaults to `o`.

er
--

    $cow.er = 'x';
    say "The right eye is {$cow.er}";

Specify (or retrieve) the character to be used for the right eye in the graphic. Defaults to `o`.

U
-

    $cow.U = 'U ';
    say "The tongue is {$cow.U}";

Specify (or retrieve) the characters to be used for the tongue in the graphic. Defaults to ``.

say(text)
---------

    my $graphic = $cow.say("Hello world!");

    $cow.say("Hello world!");  # prints graphic on STDOUT

Creates the "saying" graphic for the given text. Prints that graphic on `STDOUT` if called in sink context.

say
---

    my $graphic = $cow.think("Hello world!");

    $cow.think("Hello world!");  # prints graphic on STDOUT

Creates the "thinking" graphic for the given text. Prints that graphic on `STDOUT` if called in sink context.

WRITING YOUR OWN COW FILES
==========================

{$balloon} is the text balloon; it should be on a line by itself, flush-left. {$tl} and {$tr} are what goes to the text balloon from the thinking/speaking part of the picture; {$tl} is a backslash ("\") for speech, while {$tr} is a slash ("/"); both are a lowercase letter O ("o") for thought. {$el} is a left eye, and {$er} is a right eye; both are "o" by default. Finally {$U} is a tongue, because a capital U looks like a tongue. (Its default value is " ".) 

There are two methods to make your own cow file: the standalone file and the Perl 6 module.

For the standalone file, take your piece of ASCII art and modify it according to the rules above. Note that the balloon must be flush-left in the template if you choose this method. If the balloon isn't meant to be flush-left in the final output, use its `over()` method.

For a Perl module, declare that your module is a subclass of Acme::Cow:api<perl6>. See [Acme::Cow::Example](Acme::Cow::Example) for more information.

HISTORY
=======

They're called "cows" because the original piece of ASCII art was a cow. Since then, many have been contributed (i.e. the author has stolen some) but they're still all cows.

SEE ALSO
========

[cowsay](cowsay), [cowpm](cowpm)

AUTHOR
======

Elizabeth Mattijsen <liz@wenzperl.nl>

COPYRIGHT AND LICENSE
=====================

Original Perl 5 version: Copyright 2002 Tony McEnroe, Perl 6 re-imagining: Copyright 2019 Elizabeth Mattijsen

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

