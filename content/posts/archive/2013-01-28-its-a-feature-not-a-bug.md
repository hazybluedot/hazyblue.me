---
title: It's a Feature, not a Bug
created_at: Mon, 28 Jan 2013 20:47:51 +0000
kind: article
published: true
tags:
- ! '*nix'
- ece2524s13
- Internet
- technology
- vtclis13
---

In his article
[The internet: Everything you ever need to know](http://www.guardian.co.uk/technology/2010/jun/20/internet-everything-need-to-know),
John Naughton lists nine key concepts about the Internet to help us
understand that profound impact it is having, and will continue to
have, on our lives. Reading number 3 "DISRUPTION IS A FEATURE, NOT A
BUG" I found myself drawing parallels to the design of the Internet
and the design of the Unix operating system. The similarities are no
accident, as the history of Unix and the Internet became closely
intertwined after DARPA's 1980 decisions that the BSD Unix team would
implement the brand new TCP/IP stack which controls how data packets
are routed between machines on the Internet.  Of the design of the
Internet, Naughton says

>  It was based on two axioms. Firstly, there should be no central
>  ownership or control – no institution which would decide who could
>  join or what the network could be used for. Secondly, the network
>  should not be optimised for any particular application. This led to
>  the idea of a “simple” network that did only one thing – take in
>  data packets at one end and do its best to deliver them to their
>  destinations.

<!-- more -->

The result of this was a general purpose
network from which sprang a diverse collection of services and
applications (including the World Wide Web, see item number 2), some
of which began disrupting established industries. This
disruption, Naughton argues, is a desirable effect, though not
necessarily to the existing music labels and media
distributor behemoths such Warner Music Group and others that are
having to drastically rethink their business models to remain relevant
in the era of peer-to-peer data networks. Like the Internet, Unix was
designed around a number of axioms, the relevant ones being that the
system should provide a core set of well defined, simple system calls
for interacting with hardware and data, and that passing data between
processes should be as easy as possible. As a result of these design
choices an environment of diverse programs, each of which "do one
thing and one thing well" and can easily share data with other
programs has developed. The end result of this can be thought of as a
direct contrast to this description by Eric Raymond in his book
[The Art of Unix Programming](http://www.catb.org/esr/writings/taoup/html/ch01s05.html):

> Many operating systems touted as more ‘modern’ or ‘user friendly’
> than Unix achieve their surface glossiness by locking users and
> developers into one interface policy, and offer an
> application-programming interface that for all its elaborateness is
> rather narrow and rigid. On such systems, tasks the designers have
> anticipated are very easy — but tasks they have not anticipated are
> often impossible or at best extremely painful.

Unix users, on the other hand, have consistently been able to
complete tasks that were never anticipated by the original designers,
a key factor in its continued relevance.  As technology changes and
users demand new tools and applications developers on other systems
have to work a lot harder and are at the mercy of the system
developers to make changes to the underlying system to continue to
produce cutting edge software solutions.  On a Unix system it is just
as easy to copy a file from your USB  flash drive to your hard drive
as it is to copy a file from your harddrive to a machine on the other
side of the world and it is just as easy to stream video data from a
local file as it is from a server on the internet.  The design has
lead to a remarkable, even surprising degree of flexibility and
usefulness:

> Unix has supported a mind-bogglingly wide spectrum of uses. No other
> operating system has shone simultaneously as a research vehicle, a
> friendly host for technical custom applications, a platform for
> commercial-off-the-shelf business software, and a vital component
> technology of the Internet. <cite>- Eric Raymond, The Art of Unix
> Programming</cite>

Like the Internet, the simple infrastructure layer by Unix (and its
present-day incarnations such as BSD and GNU/Linux) provides an
environment for nearly unlimited creativity, one which continues to
surprise users and non-users alike with its ability to solve problems
and implement ideas that a year ago didn't even exist.  And likewise,
the disruption it has caused has been a boon to individuals: The Linux
based Android operating system is running on
[over half the world's smart phones](http://www.gartner.com/newsroom/id/2237315)
and
[quickly overtoke](http://en.wikipedia.org/wiki/Mobile_operating_system#Market_share) more
established contenders such as Apple's iOS. Linux has already
disrupted the
[server market, the embedded market and most recently the phone market](http://softwareandunicycles.wordpress.com/2010/07/31/does-desktop-linux-need-a-killer-app/).  It
remains to be seen whether or not it will have a noticeable impact on
Microsoft's stranglehold on the desktop market, unless you consider
Apple's Unix derived OS X as an example.
