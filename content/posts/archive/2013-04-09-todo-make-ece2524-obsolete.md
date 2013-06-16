---
title: ! 'ToDo: Make ECE2524 Obsolete'
created_at: Wed, 10 Apr 2013 03:53:47 +0000
kind: article
published: true
tags:
- ece2524s13
- engineering education
- GEDI
- programming
- vtclis13
---

Why would I want to eliminate the course that I've been teaching the
past four semesters, that I have put so many hours into to update
content, create new assignments, written (and re-written each
semester… another topic altogether) a set of scripts to facilitate
reviewing stacks of programming assignments and generally had a great
time with?

Well, because I don't think it should be a separate course to begin
with. As many have noted, and I have agreed, ECE2524 in many respects
is a kind of a "catch-all" course for all those really important
topics and tools (version control, anyone?) that just don't get
covered anywhere else. It is also officially (but not rigorously
enforced in the form of a prereq) to be an introduction to more
advanced software engineering courses, so it has the general feel of a
programming course.

<!-- more -->

I think programming (and *nix OS usage and philosophy) is too
important to delegate off to a 2 credit course and treat separately
from the rest of the engineering curriculum, an idea that was
solidified after reading an excerpt from Mindstorms by Seymour Papert.

> I began to see how children who had learned to program computers
> could use very concrete computer models to think about thinking and
> to learn about learning and in doing so, enhance their powers as
> psychologists and as epistemologists.


Papert is a strong advocate to introducing computer programming to
children at an early age and using it as a tool to learn other
disciplines

>The metaphor of computer as mathematics-speaking entity puts the
>learner in a qualitatively new kind of relationship to an important
>domain of knowledge. Even the best of educational television is
>limited to offering quantitative improvements in the kinds of
>learning that existed without it… By contrast, when a child learns to
>program, the process of learning is transformed. It becomes more
>active and self-directed. In particular, the knowledge is acquired
>for a recognizable personal purpose.

It goes without saying that a solid understanding of math is crucial
for any of the STEM fields, but computers and programming can also
encourage engagement with
[other fields as well](http://blogs.kqed.org/mindshift/2013/04/combining-robotics-with-poetry-art-and-engineering-can-co-exist/),
though that is not the focus of this post.

Along with being a useful skill to have, programming teaches a
systematic way of thinking about a problem, and crucially shifts the
model of learning from one that embodies a "got it" and "got it wrong"
binary state to one that encourages the question "how do I fix
it?". As Papert notes, and I can personally attest, when writing a
program you never get it right the first time. Becoming a good
programmer means becoming an expert at tracking down and fixing bugs.

> If this way of looking at intellectual products were generalized to
> how the larger culture thinks about knowledge and its acquisition,
> we all might be less intimidated by our fears of "being wrong."

Some strong arguments for the symbiosis of programming and learning
valuable thinking skills at an early age. But the benefits don't
disappear at the college level, especially in a field such as
engineering in which learning programming for the sake of programming
is a valuable skill (there are several required classes on the
subject, so you know it must be important. Slight sarcasm, but it's
true, regardless of how cynical we agree to be about the way classes
are structured and the curriculum is built for us). If programming can
help engage with learning mathematics, and as a side effect get us
thinking about how we think, and shift our view of learning to a more
constructive one, then can't we get at least the same positive affects
if we apply it to more advanced concepts and ideas? It doesn't hurt
that a good chunk of engineering is mathematics anyway.

The wheels really started turning after the first day of
guest-lecturing for Signals & Systems. Here's a course that is a lot
of math, but critically foundational for learning how to learn about
how the world works. That may seem a little embellished, especially
for those not familiar with the field (Signals & Systems crash course:
a system is anything that has an input signal and produces and output
signal, e.g. a car (input is gas/break, output is speed), a heart beat
(input is electrical signal transmitted along nerves, output is muscle
contraction or blood flow), the planet (so many systems, but treating
atmospheric concentrations of CO2 and other gases as an input and the
average global temperature would be one example of a system we would
be interested in studying)). Signals & Systems provides a set of tools
for exploring the input/output relationships of… anything.

So why is it taught from a set of slides?

What better way to really engage with and understand the theory than
USE it? Now most educational budgets wouldn't be able to cover the
costs if everyone wanted to learn the input/output behavior of their
own personal communications satellite, but the beauty of Signals &
Systems, and the mathematical representations that it embodies, is
that everything can be simulated on a computer. From the velocity of a
car, to blood flow caused by a beating heart, to the motion of the
planets and beyond.

I envision a Signals & Systems course that is mostly
programming. People will argue that the programming aspect of the
material is just the "practical implementation", and while that's
important, the theory is critical. Yes, the theory is what helps us
develop a generalized insight into different ways of representing
different types of systems and what allows us to do a good deal of
design in a simulated environment with greatly reduced risks,
especially when say, designing new flight controls for a commercial
jet.

But I think the theory can be taught alongside the programming for a
much richer experience than is obtained by following a set of
slides. You want to understand how the
[Laplace transform](http://en.wikipedia.org/wiki/Laplace_transform)
works? What better way than to implement it on a computer. I guarantee
you, if you have to write a program that calculates the Laplace
transform for an arbitrary input signal, by the time you're done with
the debugging, you're going to have a pretty good understanding of
whats going on, not to mention a slew of other important experiences
(how do you solve an integral on a computer anyway?).

Talking about the differences between continuous time systems and
discrete time systems is taken to a whole new level when you start
trying to simulate a continues-time system on a computer, very much a
discrete-time system. How do you even do that? Is it sufficient to
just use a really really small time step?

So yes, I think the best case scenario would be one in which ECE2524:
Intro to Unix for Engineers is obsolete[^focus]. Not because the topics we
cover are unimportant, quite the contrary, they are so important that
they should be providing a framework for learning engineering.

Footnotes:
-----------

[^focus]: I've focused primarily on the programming aspect of ECE2524
    here, but those of you who know me and have taken the course with
    me know that the Unix philosophy is a big part of it as
    well. Integrating the programming aspects into other coursework
    would of course not address that. I'm sure, with a little thought
    we all can think up a clever way of introducing the *nix
    philosophy and generally the whole concept of thinking about a
    philosophy when thinking about engineering, and what that even
    means, with every other course. Because well, it should be an
    integral part of everything else we learn.

