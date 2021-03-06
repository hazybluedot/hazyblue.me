---
title: ! 'And Now You''re an Astronaut: Open Source Treks to The Final Frontier'
created_at: Wed, 15 May 2013 17:09:32 +0000
kind: article
published: true
tags:
- ! '*nix'
- ECE2524
- ece2524s13
- gpl
- iss
- linux
- nasa
- open source
- technology
- vtclis13
---

There have [been](http://blogs.lt.vt.edu/leonp/2013/05/08/here-comes-linux/) a [couple](https://blogs.lt.vt.edu/hussaino/2013/05/15/linux-dominating-space/) of blog posts recently referencing the recent switch [NASA](http://www.nasa.gov/) made from Windows to [Debian 6](http://www.debian.org/), a [GNU/Linux](http://www.gnu.org/gnu/linux-and-gnu.html) distribution, as the OS running on the laptops aboard the [International Space Station](http://www.nasa.gov/mission_pages/station/main/index.html). It's worth noting that Linux is no stranger to the ISS, as it has been a part of ground control operations [since the beginning](http://www.linux-magazine.com/w3/issue/12/Linux_on_the_International_Space_Station.pdf%20).

The reasons for the space-side switch [are quoted](http://www.zdnet.com/to-the-space-station-and-beyond-with-linux-7000014958/) as

> ...we needed an operating system that was stable and reliable -- one
> that would give us in-house control. So if we needed to patch,
> adjust, or adapt, we could.

This is satisfying to many Open Source/Linux fans in its own right: a
collaborative open source project has
[once again](http://en.wikipedia.org/wiki/Internet) proved itself more
stable and reliable for the (relatively) extraordinary conditions of low
Earth orbit than a product produced by a major software giant. Plus
one for open source collaboration and peer networks!

<!-- more -->

But there's another reason to be excited. And it's a reason that would
not necessarily apply
([mostly](https://www.youtube.com/watch?v=7XTHdcmjenI#t=9m08s)) to,
say, Apple fanatics had NASA decided to switch to OS X instead of
Debian. And that reason has to do with the collaborative nature of the
open source movement, codified in many open source licenses under
which the software is released. Linux, and the GNU tools, which
together make up a fully functional operating system, are released
under the
[GNU General Public License](http://www.gnu.org/copyleft/gpl.html). Unlike
many licenses used for commercial software, the GPL ensures that
software licenses under its terms remains free for users to use,modify
and redistribute. There are certainly some strong criticisms and
[ongoing debate](https://blogs.oracle.com/roumen/entry/sun_s_criticism_of_gpl)
regarding some key aspects of the GPL, especially
[version 3](http://www.osnews.com/story/19133/Torvalds_Still_Will_Not_License_Linux_Under_GPL_v3/),
the point of contention mostly lies in what is popularly called the
"viral" effect of the license: that modified and derived work must
also be released under the same license. The GPL might not be
appropriate for every developer and every project, but it embodies the
spirit of open source software in a way that is agreeable with many
developers and users.

So what does this all mean in terms of NASA's move? We already know
that they chose GNU/Linux for its reliability and stability over
alternatives, but that doesn't mean it's completely bug free, or will
always work perfectly with every piece of hardware, which after all is
another reason for the switch: no OS will be completely bug free or
always work with all hardware, but at least Debian gives NASA the
flexibility of making improvements themselves. And there in lies the
reason for excitement. While there is no requirement that NASA
redistribute their own modified versions of the software, there is no
reason to assume they wouldn't in most cases, and if they do, it will
be redistributed under the same license. It's certainly realistic to
expect they will be directing a lot of attention to making the Linux
kernel, and the GNU tools packaged with Debian even more stable and
more reliable, and those improvements will make their way back into
the general distributions that we all use. This means better hardware
support for all GNU/Linux users in the future!

And of course it works both ways. Any bug fixes you make and
redistribute may make their way back to the ISS, transforming
humanity's thirst for exploring "the final frontier" into a truly
collaborative and global endeavor.

