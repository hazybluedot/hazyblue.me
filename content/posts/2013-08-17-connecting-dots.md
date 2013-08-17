---
title: Connecting Some Dots
published: true
kind: article
created_at: '2013-08-17 08:00:00 -0400'
tags:
  - education
  - pedegogy
  - instruction
  - narrative
---

Content is King, or that's the way it seems in STEM higher ed these
days. It starts with a list of topics that will be covered (or should
be covered, if the list is formed by committe) and continues with
statements like "We need to wrap up topic A today so that we stay on
schedule and start topic B tomorrow" in class. Content topics are
nothing more than
[Whitehead's bits of information](/2013/06/whitehead-on-the-holodeck/),
so why do we let them define the curriculum?

<!-- more -->

Content is important, but not, perhaps, any particular piece of
content. After my [LEGO Post](/2013/06/whitehead-on-the-holodeck/),
[@TonyBrainstorms](https://twitter.com/TonyBrainstorms) and I had a
discussion about chunks of content. In a LEGO construction the chunks
are relatively large, big enough to be clearly visible in the final
product, while the chunks used in 3D printers are quite small.  In
both cases, design freedom comes not from the content itself, but
rather the types of connections that are allowed between any two
pieces of content.  The connections allowed in LEGO bricks follow a
set of rules implicitly defined by the rigorous design and
manufacturing of each brick. The connections allowed between bits of
content that a 3D printer is working with are defined by chemistry,
and then the type of material that satisfies the chemical requirements
is chosen by a human designer.

The Internet is another good example of a system defined by strict
adherence to connection specifications but lax to no restrictions on
content. The protocol used, TCP/IP, dictates how chunks of information
are sent from one place to another, without any regard for what each
chunk contains. The strict guidelines of how to transmit data, while
being content-agnostic provides the basis for the vast, ever growing
array of experiences to be found on the internet.

Could we do something similar with education? If we assume that some
sort of standards are necessary to ensure everyone has access to a
reasonably consistent educational experience, regardless of the school
they attend, could we instead of structuring the standard by defining
the content, define it by the structure.

This idea ties in nicely with
[problem-based learning](http://en.wikipedia.org/wiki/Problem-based_learning). Start
each semester/class/degree with a problem to solve. Ideally, let each
student formulate his or her own problem based on personal interests
(logistics still to be worked out ;-)). Provide structure, tools, and
instruction focused on aiding in solving the problem.

It's not that we don't care about content, it's just that we will pick
what content to cover based on how it connects to things we already
know, and if it fits in along the path towards our end goal (a
completed project).

If we're going to take Computer Systems Engineering as an example
(which we will, because that's my background, but I'd love to hear
ideas for other areas), let's say we'd like to build a simple CPU, and
we have 4 years to do it.

- We'll first have to make sure everyone is on the same page with what
  a CPU is, and what role it plays in a finished computer system.
- Next, we'll want to figure out what the major components of a CPU
  are, but to do this we'll need to talk a little bit about how CPUs
  are used.
- We can assume everyone has working knowledge of a commercially
  available computer, so we'd start by talking about the software
  we're familiar with, how it interacts with an operating system (at a
  very high level), and in turn, what resources a CPU might need to
  provide.
- We will quickly discover that a modern consumer-grade computer is
  far more complex than we need, and the complexity will make it
  difficult to analyze and think about each part. Let's look at a
  [Raspberry Pi](http://www.raspberrypi.org/), instead.
- We'll start by installing Linux on our Pi to get a sense of how the
  different pieces of an operating system fit together to provide a
  general purpose working environment.
- Since ultimately, we want to build a CPU, let's explore computation
  in some more detail, starting with simple arithmetic. We'll install
  Python on our Pi and play around with simple arithmetic
  expressions. How does the computer understand the expressions and
  compute the results?

~~~
>>> (2 + 3) * 5
25
>>>
~~~

  - How does the computer parse the string of numbers and symbols into something it can work with
  - How is the computer's representation of the expression then solved?
  - What is the role of the OS vs. the CPU vs. other hardware?

- At this point we could go more into depth on any of the previously
  mentioned questions. Which one we explore first may be a matter of
  interest, but clearly we're going to have to start talking about
  binary representation (if that didn't already come up in year 1),
  data structures (representing `(2 + 3) * 5` on a stack, or as an
  AST, how that data structure may be traversed, and then how the
  computations are performed (binary arithmetic).
- Let's focus on the binary arithmetic part. We'll need to talk about
  boolean logic and the different logic gates.  Let's make sure to do
  some lab work along side these discussions to build simple logic
  circuits out of basic electrical components. We'll also quickly see
  the need to abstract away complexity. As we understand smaller
  pieces, let's encapsulate them into higher level "black box" ideas
  that we can fit together to form yet more complex circuitry.
- Now is a good time to talk about the theory of computing: ideas like
  Turing machines, people like
  [Alan Turing](https://en.wikipedia.org/wiki/Alan_Turing) and
  [George Boole](https://en.wikipedia.org/wiki/George_Boole) along
  with [Ada Lovelace](https://en.wikipedia.org/wiki/Ada_Lovelace) and
  [Charles Babbage](https://en.wikipedia.org/wiki/Charles_Babbage) to
  put the idea of general purpose computing in historic
  perspective. And to emphasize that a general purpose computational
  engine need not be electronic, the idea is much more general!
- We'll quickly discover that the basic 2 terminal electrical
  components (resistor, capacitor, inductor, (memristor?)) are
  insufficient to build what we want to build. We need some way to
  "switch" current on and off. Better talk about semi-conductors,
  including diodes and transistors. Don't forget to put things in
  context with a look at vacuume tubes.
     - the
       [story of the memristor](http://spectrum.ieee.org/semiconductors/design/the-mysterious-memristor)
       is a fascinating piece of history, and a beautiful example of
       the theoretical predicting the eventually observed physical.
- It's not time or cost effective to build all the circuits we might
  want to test, so we'd better talk about basic circuit analysis so
  that we can start doing simulation work on our Raspberry Pi. Of
  course talk of circuit analysis will pull in differential equations
  and linear algebra. How does [Gustav Kirchhoff](https://en.wikipedia.org/wiki/Gustav_Kirchhoff) fit in to all of this?
  - how do we solve differential equations on a computer?
  - matrix operations?
  - let's talk about algorithms and write some Python code to test our ideas.
- Clearly our computers are built out of analog components, but we've
  already established they work digitally. Why?
- Since we'll need to simulate a simple transistor, we'll need to talk
  a bit about semi-conductor physics and chemistry.
- after we've built a few logic gates out of discrete components in
  the lab we'll want to move on to experimenting with integrated
  devices, to continue our theme of abstracting away details.
- at this point we've been doing a fair amount of programming to
  simulate low-level electrical components, data structures and
  algorithms. We could spend some more time exploring the relationship
  between software/hardware/programming languages and general problem
  solving concepts.
- since we have a good handle on the basics of how the arithmetic is
  done, we can now explore different instructions sets. What are the
  trade offs between a simple instruction set and architecture in
  which one instruction is complete in one clock cycle, and a complex
  architecture in which a single instruction may take several clock
  cycles? How does the architecture used by general purpose processors
  found in consumer grade computers fall into the spectrum? What about
  our Raspberry Pi? How about a Micro controller?

So I haven't quite got it to our goal yet.  Perhaps a sub-goal of
understanding how a CPU works, which would be necessary before
building one. The previous outline is pretty rough, and was very much
a free-writing exercise, so bare that in mind.

I just had a pre-meeting yesterday to start making changes to a
sequence of programming courses to make a more consistent experience
for students, so I'll try to write a narrative out for that in a few
days, as it should be easier to do for a four semester sequence than a
four year degree! Until then... what are your thoughts on this? Is
there too much focus on content and topics? Would shifting the focus
to telling a story be an improvement?
