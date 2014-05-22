---
title: Who's flying this thing? 
subtitle: Lack of clear education goals result in sub-optimal learning experiences
published: true
kind: article
created_at: '2014-03-21 20:27:46 -0400'
author_name: hazybluedot
tags: curriculum, goals
---

In the assessment class I'm taking the first thing we learned about
creating assessments is that having clear goals are a prerequisite to
everything else. Based on my own experience and what I've heard from
others, I wonder if the folks who have had a hand in developing the
computer programming components of the engineering curriculum had any
goals in mind aside from "learn basic programming skills".

<!-- more -->

The impression I get is that when most people think about computer
programming and curriculum design, at least here at Tech, it is in the
form of "Programming in C++" or "Programming in LabVIEW" or
"... MATLAB", or ... The point being that there seems to be an
overfocus on the tool or the environment or the language which makes
me wonder if the people who put the programming requirement in the
curriculum, or the people who have been implementing it have talked to
one another, or if either party knows what they really mean when they
say things like "Engineers should have basic programming skills".

Recently I wrote a critique of
"[Reformulating General Engineering and Biological Systems Engineering Programs at Virginia Tech][Lohani2011]"
which covered some changes that were made to the first-year
engineering program at Virginia Tech back in 2004 as part of a larger
funded project to implement a [spiral curriculum][spiral_curriulum] in
the BSE degree. Due to the nature of the curriculum structure at
Virginia Tech the effort also required a restructuring of the first
year general engineering courses which provide an introduction to a
broad range of topics, including programming.

According to the authors, initially the programming module was
reworked to use [Alice](http://www.alice.org), an open source project
out of [Carnegie Mellon](http://www.cmu.edu/index.shtml) designed to
teach basic programming concepts through creating stories through a
graphical interface.

> While several first time programmers liked the programming approach
> in the Alice environment and pre-and post-test results showed positive
> learning gains [41], repeated assessments including focus groups with
> students showed that students, particularly those with prior
> programming experience, did not enjoy the Alice programming
> environment.

and so without much discussion or reflection the authors reported
their solution

> Based on systematic evaluation of all assessment data, we decided to
> replace Alice with LabVIEW programming in spring 2007.

and moved on to reporting the merits of LabVIEW.

[Lohani2011]: http://advances.asee.org/wp-content/uploads/vol02/issue04/papers/aee-vol02-issue04-p11.pdf
[spiral_curriulum]: http://serendip.brynmawr.edu/exchange/wfrankli/ii09/spiral.curriculum

I was immediately struck with a queezy feeling after reading this
section. I think this was due to a number of reasons, that one that
was easiest to identify at first was that there was the move from an
open source solution to a proprietary solution with a disregard for
the immediate reduction in educational potential [^ossed].

My disagreement with the nature of this switch went further than a
philosophical difference but it took some time before I could really
articulate what it was that bothered me.

First, according to the
[Alice](http://www.alice.org/index.php?page=what_is_alice/what_is_alice)
website:

> Alice is a freely available teaching tool designed to be a student's
> first exposure to object-oriented programming. It allows students to
> learn fundamental programming concepts in the context of creating
> animated movies and simple video games.

yet there was no reference in the report to the focus on story telling
[^oldalice].  It wouldn't surprise me that there would be some
pushback against a tool like this from students with prior programming
experience, but what would surprise me even less is a general
dissatisfaction resulting from using a tool contrary to its intended
purpose.  What remains unclear from the report is whether the
introductory programming course was restructured to leverage the
story-telling focus of [Alice], or if the conventional approach of
introducing logical constructs, looping techniques, etc. was simply
adopted to the [Alice] interface. Given the lack of evidence to the
contrary, and my general skepticism, I am forced to conclude the later
scenario was likely the case, and if that's true then why *would*
anyone expect good results?

Second, as advertised, [Alice] has a focus on story telling via
[object-oriented programming][wiki:oop]. In contrast, LabVIEW
programming follows the [dataflow paradigm][wiki:dataflow] and was
originally intended to allow non-programmers to easily interface to
lab equipment (naturally lab equipment provided by National
Instruments), though later renditions have become more general purpose
[^dslgen].  These are two very different tools that are built around
different programming paradigms with very different intended usage. It
is ridiculous to assume that they could be used as drop-in
replacements for one another and yet based on the information provided
in the report, it appears that is exactly the assumption that was
made.

[Alice]: http://www.alice.org
[wiki:oop]: http://en.wikipedia.org/wiki/Object-oriented_programming
[wiki:dataflow]: http://en.wikipedia.org/wiki/Dataflow_programming

The conclusion I came to was that no one (including myself, currently)
really has a clear goal regarding what it means for engineers to have
basic programming knowledge.  Do we mean that engineers should be
familiar with a particular programming language? That they have an
understanding of logic and computation thinking? That they should have
an understanding of different programming paradigms in use and the
strengths and weaknesses of various languages? No one seems to have a
good answer and this ambiguity is reflected in the curriculum. The
result is a general inconsistency across the programming curriculum,
wide variance from semester to semester and instructor to instructor
and general dissatisfaction, especially from students with prior
programming experience.

I'm still thinking about specifics, but I would argue that just the
act of defining what our goals are and redesigning the programming
experience around a consistent set of principles will result in an
improved learning experience, even if we find that our initial set of
goals isn't perfect.

I will write about the results of an initial brainstorming session I
had today regarding the goals of a programming experience in ECE, but
in the mean time please share your own thoughts in the comments.  What
kind of programming skills and experience should engineers have upon
graduation? How does/should this vary across engineering disciplines?

### Footnotes

[^ossed]: this is probably a topic for its own post, but I am of the strong opinion that proprietary software is antithetical to the ideals of education. If both an open source and proprietary solution to a problem exist, in an educational environment we should always use the open source solution.

[^oldalice]: it's also quite possible that the version of Alice available in 2004 did not have this same emphasis, I have been unsuccessful in my attempts to obtain and install the version of Alice that would have been available at that time. While I applaud Carnegie Mellon's decision to use an open source license they could certainly improve the availability of archived versions of the code by providing public access to the version controlled source.

[^dslgen]: I am also immediately skeptical of the general purpose usefulness of any domain specific language that has been generalized. In my own experience using LabVIEW it remains a very capable tool for quickly building very nice interfaces to instruments, but its general purpose programming functionally is near useless in terms of collaboration and maintainability for anything more than the simplest of programs.
