---
title: 'Where Have all the Literate Programmers Gone?'
published: true
kind: article
created_at: '2014-02-08 11:53:54 -0500'
author_name: hazybluedot
tags: ["literate programming", "programming", Knuth]
---

> I believe that the time is ripe for significantly better
> documentation of programs, and that we can best achieve this by
> considering programs to be works of literature.
> -- Donald Knuth, [Literate Programming][knuthweb]

[knuthweb]: http://www.literateprogramming.com/knuthweb.pdf

I was first introduced to the concept of [Literate Programming][LP]
last year while I was searching for interesting Unix pipelining
examples for [ECE2524] and stumbled upon
[this blog post][more_shell_less_egg]. At the time, as my focus was
more on the pipeline example, I didn't look too closely at any
Literate Programming resources out there, instead focusing on
McIlroy's review of Knuth's LP example in which he claims that his 6
line shell script is just as readable and much more succinct than
Knuth's 10+ pages of Pascal interposed with prose. I filed Literate
Programming in the back of my mind as one of those ideas that never
really caught on for whatever reason and continued on my way. It turns
out that the story of LP is more interesting and nuanced than I had
originally thought.

[more_shell_less_egg]: http://www.leancrew.com/all-this/2011/12/more-shell-less-egg/
[LP]: http://www.literateprogramming.com
[ECE2524]: https://computing.ece.vt.edu/~ece2524/

<!-- more -->

Fast forward to this semester, I am using McIlroy's pipeline again,
now as a unifying idea (possibly for the entire semester, if I can
pull it off) and I noticed from quiz results that there was some
confusion over what exactly Literate Programming is: Understandably,
given the [reading and my introduction][word_count_intro], several
people sited McIlroy's pipeline as an example of LP, which based on my
limited understanding, it is not. Perfect motivation for addressing
the issue of my limited understanding (if you ever want to learn a
whole lot about a topic, try teaching it ;-) ).

[word_count_intro]: https://computing.ece.vt.edu/~ece2524/activities/word_count_intro/

And so I started searching. And reading.

Donald Knuth, creator of [TeX], author of the venerable "[The Art of
Computer Programming]", published a series of papers and eventually
[a book][LP_book] describing his system for writing code and prose in
the same source file which could later be used to generate both
documentation and a compiled program.

[LP_book]: http://www-cs-faculty.stanford.edu/~uno/lp.html
[TeX]: http://www.tug.org/whatis.html
[TAOCP]: http://en.wikipedia.org/wiki/The_Art_of_Computer_Programming

At first glance, this sounds a bit like what tools like [Doxygen] aim
to do, and both start from the same goal: Writing code and
documentation at the same time, in the same file. If number of
[document generation projects] is any indication, this is certainly a
popular idea.  Where LP differs from most approaches is its focus on
the human reader over the compiler: Literate Programming is writing
prose with code snippets, where as most of the other approaches,
including the one used by Doxygen is the reverse: extracting
documentation from comments in source code.

[Doxygen]: http://www.stack.nl/~dimitri/doxygen/
[document generation projects]: http://en.wikipedia.org/wiki/Comparison_of_documentation_generators

While a Doxygen comment may appear as a comment in source code:

~~~ c
/* \brief print "hello world"
 *
 * Print the string "hello world" to standard out.
 */
 void hello_world() {
     printf("%s\n", "Hello World");
 } 
~~~

Literate Programming flips the representation so that the text
description contains blocks of code, and in fact it works as a macro
language: code blocks are labeled with natural-language names which
are expanded out by the interpreter to construct a valid source file
in the target programming language.

~~~ text

If we want to print a message that states "Hello World" we can write a
function to do so

<<hello_world>>=
void hello_world() {
     printf("%s\n", "Hello World");
}
@

This makes use of the `printf` function in the standard C library.
~~~

The Doxygen style produces a good API reference of the program, while
the LP style generates a cohesive essay.

LP is a system of combining source code and prose using whichever
language is most appropriate for each, in his original examples Knuth
writes his prose using TeX and is code in Pascal, but one could also
write in Markdown and C, assuming one had the necessary tools to
implement the LP processing chain.

The human-centric starting point of Literate Programming seems to
align nicely with the Unix design philosophy of writing code with
future developers in mind over the compiler.  Dennis Ritchie knew
human-readability was more important than compiler optimization and
encouraged developers to write modular code even at a time with the
performance price was not insignificant:

> Dennis Ritchie encouraged modularity by telling all and sundry that
> function calls were really, really cheap in C. Everybody started
> writing small functions and modularizing. Years later we found out
> that function calls were still expensive on the PDP-11, and VAX code
> was often spending 50% of its time in the CALLS instruction. Dennis
> had lied to us! But it was too late; we were all hooked... -- Steve
> Johnson [TAOUP]

[TAOUP]: http://www.catb.org/esr/writings/taoup/html/modularitychapter.html

However, I've been a *nix fan and user for many years now and have yet
to come across an example of production code written in a LP style.
My initial conclusion that it simply hadn't caught on isn't quite
accurate. There seems to be an active community surrounding LP and
[at least two](http://www.desy.de/user/projects/LitProg.html) largish
repositories of LP examples.  I think McIlroy's review of Knuth's
example WEB program provides much insight as to why LP has remained
primarily an academic curiosity.

> A first engineering question to ask is: how often is one likely to
> have to do this exact task’? Not at all often, I contend. It is
> plausible, though, that similar, but not identical, problems might
> arise. A wise engineering solution would produce-or better,
> exploit-reusable parts. -- Doug McIlroy,
> [A Literate Program][bentley_pearls]

[bentley_pearls]: http://doi.acm.org/10.1145/5948.315654

Of course, exploiting reusable parts is precisely what the Unix
environment allows and encourages. For many *nix users, this has
become a way of thinking about programming, a way of life. What does
the guy who literally wrote THE book on the subject think?

> I also must confess to a strong bias against the fashion for
> reusable code. To me, "re-editable code" is much, much better than
> an untouchable black box or toolkit. I could go on and on about
> this. -- Donald Knuth,
> [Interview with Donald Knuth][knuth_interview]

[knuth_interview]: http://www.informit.com/articles/article.aspx?p=1193856&ns=15105

His bias against re-usable code certainly goes a long way towards
explaining why Literate Programming has worked for Knuth, though I
must confess, I don't fully understand his strong negative feelings
towards the practice. In the case of an open source library (and he
*is* as strong supporter of open source, in the same interview he is
referred to as "one of the fathers of open source") the re-usable code
isn't really locked up in a box, but you can safely pretend it is
while writing the code the calls it. In the case of
[Ruby][ruby_language] (and apparently also C#, and probably others),
the language itself provides a convenient mechanism that allows
[Monkeypatching][monkeypatching], in fact, I just exploited this
feature recently in a module that generates my blog's Atom feed.

[ruby_language]: https://www.ruby-lang.org/en/
[monkeypatching]: http://www.codinghorror.com/blog/2008/07/monkeypatching-for-humans.html

Of course Ruby is a relative newcomer to the scene, and perhaps that
and other newcomers are another piece of the puzzle in explaining why
what sounds like a Good Thing hasn't really caught on: today
programmers have a wealth of high level programming languages
available to them. Unlike Pascal or C, writing in these languages is
much closer to writing a description of what you want the computer to
do, rather than listing a sequence of low-level instructions that
produce the desired result.  These high level descriptions, combine
with suitable code comments allow most people familiar with the
language to understand what the program does on the first
read-through.

Then there is also
[Jon Bentley](http://en.wikipedia.org/wiki/Jon_Bentley)'s observation
that only small percentage of the world's population is good at
programming, and a small percentage good at writing, Knuth is asking
that everyone be member of the intersection of the two sets. Even if a
particular person is good at both, or more likely, not awful at
either, I find that the context switch from programming to explaining
is a bit of a burden. When I'm thinking about programming the models I
keep in my head tend to be a fairly abstract representation of what I
am trying to accomplish. Similarly, when I read code written by
someone else, I build up an abstract model in my head of what the code
is doing and then run the model in a mental simulation to understand
what is happening. Going between the abstract model and an English
description requires a translation step. I don't doubt that practicing
this could be incredibly useful. McIlroy acknowledges this in his
review: "reflecting upon design choices sufficiently to make them
explainable must help clarify and refine one's thinking." I suspect
Knuth is one of the rare genius that can perform this translation on
the fly without thinking much about it.

While I don't foresee using literate programming on a regular basis I
do think there is one area in which it might serve my needs nicely:
programming instruction. I have always struggled with keeping the
documentation in sync with the code, as well as the tests, that I post
for ECE2524. I have experimented with a home-baked solution of mixing
code and description but Literate Programming provides a more formal
structure as well as a wealth of existing tools, including some
already written to handle Markdown and C as the
descriptive/programming language pair. Expect further updates as I
experiment.
