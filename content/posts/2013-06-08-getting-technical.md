---
title: "Getting Technical"
created_at: 2013-06-08 18:38:39 -0400
kind: article
published: true
tags:
 - nanoc
 - css
 - haml
 - templating
 - ruby
---

Some interests seem to come and go but really are always
there. Lurking. Waiting for the right moment to make you look back and
go, 'huh'.

I remember creating my first web page in the very early years of the
web. Luckily it has long been removed from the internet, for it was a
gastly thing. But I continued to dable in web development throughout
high school and even briefly formed a LLC with a friend to create
websites for people (and back in those days open source content
management systems hadn't been created yet, so we rolled our own in
Perl). We created two, neither of which are still live in their
original form (again, this is a good thing for anyone actually wanting
to visit them). Part of my employment during my undergraduate years
was working for [OIT at UMass](http://www.oit.umass.edu/), working on
new content management techniques for their web site, and then my
first job at Virginia Tech was working on the Online Graduate
Application Processing System
([OGAPS](https://ogaps.stl.vt.edu/ogaps/)), a web based application
for viewing graduate applications to the department. When it came time
to put up a website for Spoke 'n' Beans I was at it again, though that
site is no longer active, and of course, my current project,
[illichillich.net](http://illichvillich.net) is still a work in
progress as I continue to figure out just what it is.

In one way or another I've been following the trends of web site
development ever since there was a web to develop (though sadly, I
still don't really have a nack for the 'design' part of things).

<!-- more -->

One of the aspects of web development that appeals to me, and why I
think it has been an interest for so long, is the process of
structuring data in a way that can easily be displayed in a number of
different formats. To make this possible, various technologies have been
developed over the years to facilitate the separation of content,
structure and presentation. The result can look like alphabet soup
when you find out that what you see in your web browser is made
possible by HTML, CSS, JavaScript, PHP, CGI, SQL, to name a few.

## In the beginning

Hypertext Markup Language (HTML) was developed by Tim Berners-Lee at
CERN in 1989. The purpose was to provide a means to link bits of
research papers together to facilitate collaboration between particle
physisists. In a nutshell, Berners-Lee started with the established
SGML which defined things like headers, paragraphs and lists and added
the `href` attribute to the anchor element[^1].

A simple HTML file looks like this

~~~ html
<html>
  <body>
    <h1>Hello World</h1>
    <p>This is a <em>paragraph</em> with a link to <a href="http://www.google.com">google</a>.</p>
  </body>
</html>
~~~

While it is fairly easy to read and figure out what's what, it is
structured in a way that makes it easy for a computer to
understand. HTML is a subset of XML, and like its parent, while you
*could* write HTML by hand, it is tedious to get right. First, just
remembering all the tag names ('`html`, '`body`', '`h1`', '`p`', etc.)
can be a pain, and then you need to remember to properly close all
tags (e.g. '`<p>`' should always be followed by '`</p>`'), and when
you start nesting elements you need to be careful about closing tags
at their correct nesting level. I don't want to write html by hand.

## Enter Markdown

Inspired by the simple markup that became common in writing text
emails, Markdown strives for simplicity and readability.

~~~ 
# Hello World

This is a *paragraph* with a link to [google](http://www.google.com)
~~~
{:lang="mkd"}

Markdown is easier to write and easier to read, at least for
humans. The syntax itself is not as expressive as HTML, but it solves
this problem nicely by allowing raw HTML mixed in with the markdown.

[^1]: [A history of HTML](http://www.w3.org/People/Raggett/book4/ch02.html)
