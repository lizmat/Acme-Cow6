use v6.d;  # technically 2019.03

# set up the default cow
my constant default-cow = q:to/EOC/;
{$balloon}
        {$tl}   ^__^
         {$tl}  ({$el}{$er})\_______
            (__)\       )\/\
             {$U} ||----w |
                ||     ||
EOC

role Acme::Cow:ver<0.0.1>:auth<cpan:ELIZABETH>:api<perl6>[
  $cow = default-cow, |default-capture
] {
    has  Str $.cow  is rw;
    has  Str $.el   is rw = 'o';
    has  Str $.er   is rw = 'o';
    has  Str $.U    is rw = '  ';
    has  Int $.over is rw = 0;
    has  Int $.wrap is rw = 40;
    has Bool $.fill is rw = True;
    has      @.text;

    # role for making .say/.think print by themselves
    my role SinkPrints { method sink() { self.print } }

    # non-standard new that takes cow as first positional
    multi method new(*%_) {
        self.bless(:$cow, |default-capture, |%_)
    }
    multi method new(IO::Path:D $path, *%_) {
        self.bless(cow => $path.slurp, |default-capture, |%_)
    }
    multi method new(Str:D $cow, *%_) {
        self.bless(:$cow, |default-capture, |%_)
    }

    # let the cow think
    multi method think() { self.think($*IN.lines) }
    multi method think(*@text) {
        self!process-template(
          $.cow, :$.el, :$.er, :$.U, tl => 'o', tr => 'o',
          balloon => self.balloon(@text, 'think').chomp,
        ) but SinkPrints
    }

    # let the cow say
    multi method say() { self.say($*IN.lines) }
    multi method say(*@text) {
        self!process-template(
          $.cow, :$.el, :$.er, :$.U, tl => '\\', tr => '/',
          balloon => self.balloon(@text).chomp,
        ) but SinkPrints
    }

    # make the cow say what's on STDIN in void context
    method sink() { self.say.print }

    # create the text balloon for the given text
    method balloon(@text, $mode = "say") {

        # set up parameters
        my @message = self.format-text(@text);
        my $max     = @message ?? @message>>.chars.max !! 0;
        my $max2    = $max + 2;        ## border space fudge.
        my $shove   = " " x $.over;
        my $format  = "$shove%s %-{$max}s %s\n";

        # set up border markers
        my @border; ## up-left, up-right, down-left, down-right, left, right
        if $mode eq 'think' {
            @border = < ( ) ( ) ( ) >;
        }
        elsif @message < 2 {
            @border = << < > >>;
        }
        else {
            @border = < / \ \ / | | >;
        }

        # create the final result and return it
        my @result =
          "$shove " ~ ("_" x $max2) ~ "\n",
          sprintf($format, @border[0], @message[0] // "", @border[1])
        ;
        if @message >= 2 {
            @result.push(
              sprintf($format, @border[4], $_, @border[5])
            ) for @message[1 .. *-2];
            @result.push(
              sprintf($format, @border[2], @message[*-1], @border[3])
            );
        }
        @result.push("$shove " ~ ("-" x $max2) ~ "\n").join
    }

    method format-text(@text) {
        my @lines = @text>>.trim-trailing>>.subst("\t", "        ", :g);
        $.fill ?? self.wrap-text(@lines) !! @lines
    }

    # do the actuall wrapping (simple case of Text::Wrap)
    method wrap-text(@lines) {
        my @result;
        my $current = "";
        my $count;
        my $empty;

        # make sure we keep initial whitespace
        my @words = @lines.join(" ").words;
        @words.unshift($0.chop) if @lines[0] ~~ m/^ (\s+) /;

        # for all the words
        for @words -> $word {
            $count = $current.chars;

            # something already
            if $count || $empty {

                # won't fit
                if $count + 1 + $word.chars > $.wrap {
                    @result.push($current);
                    $current = $word;
                }

                # fits
                else {
                    $current = "$current $word";
                }
                $empty = False;
            }

            # single word doesn't fit, just use the whole word
            elsif $word.chars >= $.wrap {
                @result.push($word);
            }

            # start a new line
            else {
                $word ?? ($current = $word) !! ($empty = True);
            }
        }

        # final cleanup
        @result.push($current) if $current;
        @result
    }

    # Text::Template in a nutshell
    method !process-template($text, *%mapper) {
        $text.subst(/ '{$' (\w+) '}' /, -> $/ { %mapper{$0} }, :g)
    }
}

=begin pod

=head1 NAME

Acme::Cow - Talking barnyard animals (or ASCII art in general)

=head1 SYNOPSIS

=begin code :lang<perl6>

  use Acme::Cow:api<perl6>;

  my Acme::Cow $cow .= new;
  $cow.say("Moo!");

  my $sheep = Acme::Cow::Frogs.new(over => 20);    # Derived from Acme::Cow
  $sheep.think("Yeah, but you're taking the universe out of context.").note;

  my $duck = Acme::Cow.new("duck.cow".IO, :!fill);
  $socket.print($duck.say(qx/figlet quack/));

=end code

=head1 DESCRIPTION

Acme::Cow is the logical evolution of the old cowsay program.  Cows
are derived from a base class (Acme::Cow) or from external files.

Cows can be made to say or think many things, optionally filling
and justifying their text out to a given margin.

Cows are nothing without the ability to print them, or sling them
as strings, or what not.

=head1 METHODS

=head2 new

  my $cow = Acme::Cow.new(
    $graphic,     # string or IO::Path object, optional
    over => 0,    # move text so many spaces to right, optional
    wrap => 40,   # character positions to wrap text to, optional
    fill => True, # whether to fill the balloon with text or not, optional
    el   => 'o',  # left eye, optional
    er   => 'o',  # right eye, optional
    U    => '  ', # tongue, optional
  );

Create a new C<Acme::Cow> object.

When called in sink context, will call method C<say> on it, which will read
the text from C<STDIN> and output the graphic on C<STDOUT>.

=head2 over

  $cow.over = 20;  # move text over 20 positions
  say "Moving text {$cow.over} to the right";

Specify (or retrieve) how far to the right (in spaces) the text
balloon should be shoved.  Defaults to 0.

=head2 wrap

  $cow.wrap = 45;  # wrap text within 45 positions
  say "Wrapping text at {$cow.wrap} positions";

Specify (or retrieve) the column at which text inside the balloon
should be wrapped.  This number is relative to the balloon, not
absolute screen position.  Defaults to 40.

This value is ignored if C<fill> is False.

=head2 fill

  $cow.fill = False;
  say "Will {"NOT " unless $cow.fill} fill the text balloon";

Specify (or retrieve) whether text will be filled out inside the balloon or
not.  Defaults to True.

=head2 el

  $cow.el = 'x';
  say "The left eye is {$cow.el}";

Specify (or retrieve) the character to be used for the left eye in the graphic.
Defaults to C<o>.

=head2 er

  $cow.er = 'x';
  say "The right eye is {$cow.er}";

Specify (or retrieve) the character to be used for the right eye in the graphic.
Defaults to C<o>.

=head2 U

  $cow.U = 'U ';
  say "The tongue is {$cow.U}";

Specify (or retrieve) the characters to be used for the tongue in the graphic.
Defaults to C<  >.

=head2 say(text)

  my $graphic = $cow.say("Hello world!");

  $cow.say("Hello world!");  # prints graphic on STDOUT

Creates the "saying" graphic for the given text.  Prints that graphic on
C<STDOUT> if called in sink context.

=head2 say

  my $graphic = $cow.think("Hello world!");

  $cow.think("Hello world!");  # prints graphic on STDOUT

Creates the "thinking" graphic for the given text.  Prints that graphic on
C<STDOUT> if called in sink context.

=head1 WRITING YOUR OWN COW FILES

{$balloon} is the text balloon; it should be on a line by itself,
flush-left.  {$tl} and {$tr} are what goes to the text balloon from
the thinking/speaking part of the picture; {$tl} is a backslash
("\") for speech, while {$tr} is a slash ("/"); both are a lowercase
letter O ("o") for thought.  {$el} is a left eye, and {$er} is a
right eye; both are "o" by default.  Finally {$U} is a tongue,
because a capital U looks like a tongue.  (Its default value is "  ".) 

There are two methods to make your own cow file: the standalone file and the
Perl 6 module.

For the standalone file, take your piece of ASCII art and modify it according
to the rules above.  Note that the balloon must be flush-left in the template
if you choose this method.  If the balloon isn't meant to be flush-left in the
final output, use its C<over()> method.

For a Perl module, declare that your module is a subclass of
Acme::Cow:api<perl6>.  See L<Acme::Cow::Example> for more information.

=head1 HISTORY

They're called "cows" because the original piece of ASCII art was
a cow.  Since then, many have been contributed (i.e. the author
has stolen some) but they're still all cows.

=head1 SEE ALSO

L<cowsay>, L<cowpm>

=head1 AUTHOR

Elizabeth Mattijsen <liz@wenzperl.nl>

=head1 COPYRIGHT AND LICENSE

Original Perl 5 version: Copyright 2002 Tony McEnroe,
Perl 6 re-imagining: Copyright 2019 Elizabeth Mattijsen

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
