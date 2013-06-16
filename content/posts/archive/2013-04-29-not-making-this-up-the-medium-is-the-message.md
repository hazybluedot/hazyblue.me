---
title: ! 'Not making this up: The Medium is the Message'
created_at: Mon, 29 Apr 2013 18:40:01 +0000
kind: article
published: true
tags:
- parataxis
- the medium is the message
- Uncategorized
- vtclis13
---

I've been meaning to post something about the interesting interactions between the unix commands [fortune](http://linux.die.net/man/6/fortune) and [cowsay](http://linux.die.net/man/1/cowsay). This is not that post. Long story short, fortune prints a random tidbit to the terminal and cowsay takes an input string and draws an ASCII art cow with a speech bubble containing the text you sent to the command. In addition, there are a number of different "cows" that can be drawn and so when pairing up random fortunes and random cows can be a parataxis gold mine. Here's the command I have in my bash login script that does just that: 

~~~ bash
fortune -s | cowsay -f $( find /usr/share/cows -name '*.cow' | shuf | head -n 1 )
~~~

More on that in the "real" post, but for now, I couldn't pass this up which popped up when I opened a new terminal window just now:

~~~
  _________________________________
 / "The medium is the message." -- \
 \ Marshall McLuhan                /
  ---------------------------------
        \   \_______
  v__v   \  \   O   )
  (oo)      ||----w |
  (__)      ||     ||  \/\

~~~
{: .text}

ponder that for a bit.

