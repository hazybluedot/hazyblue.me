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

Some personal interests seem to wax and wane, but remain ever-present
in my mind. Lurking. Waiting for the right moment to make my brain think.

I remember creating my first web page in the very early years of the
web. Luckily it has long been removed from the internet, for it was a
ghastly thing. But I continued to dabble in web development throughout
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
[illichvillich.net](http://illichvillich.net) is still a work in
progress as I continue to figure out just what it is.

In one way or another I've been following the trends of web site
development ever since there was a web to develop (though sadly, I
still don't really have a knack for the 'design' part of things).

<!-- more -->

One of the aspects of web development that appeals to me, and why I
think it has been an interest for so long, is the process of
structuring data in a way that can easily be displayed in a number of
different formats. To make this possible, various technologies have been
developed over the years to facilitate the separation of content,
structure and presentation. The result can look like alphabet soup
when you find out that what you see in your web browser is made
possible by HTML, CSS, JavaScript, PHP, CGI, SQL, to name a few.

## In the beginning, there was SGML

Hypertext Markup Language (HTML) was developed by Tim Berners-Lee at
CERN in 1989. The purpose was to provide a means to link bits of
research papers together to facilitate collaboration between particle
physicists. In a nutshell, starting with the established
[SGML](http://www.w3.org/MarkUp/SGML/) which defined things like
headers, paragraphs and lists, Berners-Lee added the `href` attribute to the
anchor element[^1] to allow linking between documents.

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
understand. While you *could* write HTML by hand, it is tedious to get
right. First, just remembering all the tag names ('`html`, '`body`',
'`h1`', '`p`', '`em`', etc.)  can be a pain, and then you need to
remember to properly close all tags (e.g. '`<p>`' should always have a
matching '`</p>`'), and when you start nesting elements you need to be
careful about closing tags at their correct nesting level. I don't
want to write html by hand, and neither should you.

## Enter Markdown

Inspired by the simple markup that became common in writing text
emails, [Markdown](http://daringfireball.net/projects/markdown/)
strives for simplicity and readability. It is both a syntax, that
looks like this:

~~~ 
# Hello World

This is a *paragraph* with a link to [google](http://www.google.com)
~~~
{:lang="mkd"}

And a tool to convert text written in the markdown syntax into valid
HTML. You can get a taste for how it all works together
[here](http://daringfireball.net/projects/markdown/dingus).

Markdown is easier to write and easier to read, at least for
humans. The syntax itself is not as expressive as HTML, but it solves
this problem nicely by allowing raw HTML mixed in with the markdown.

## Make it work

A website, such as a blog, is composed of many different HTML
pages. If I store the content for each as a markdown file, I don't
want to have to run the `markdown` command umpteen times to create my
site. This is where static site generators like
[nanoc](http://nanoc.ws) come in. I just modify the compile rule in
nanoc's `Rules` file to look like this:

~~~ ruby
compile '/posts/*' do
  filter :kramdown
  layout 'post'
end
~~~

This tells nanoc to filter all files in the `posts/` directory through
the [`kramdown`](http://kramdown.rubyforge.org/) filter, a Ruby
implementation of the markdown converter. I write all my files in
markdown, but after running

~~~ bash
$ nanoc co
~~~

I get a set of HTML files!

## But Wait, There's More

The alert reader may have noted that as snazzy as the markdown to HTML
conversion is, it doesn't really cover everything needed to put
together a website. For instance, I haven't even addressed things like
headers, footers and side bars.  Markdown has limited syntax support
for structural elements, and this is a *good thing*. Typically, we
like to keep our content separate from our structure. This makes it
almost trivial to generate alternative views of content, perhaps
formatted for a small mobile screen, or converted to a PDF document.

A more complete HTML page might look like something like this:

~~~ html
<!DOCTYPE html>
<html lang='en'>
  <head>
    <meta charset='utf-8'>
    <title>#!/hazy/blue/. - Getting Technical</title>
    <link href='/stylesheets/screen.css' media='screen,projection' rel='stylesheet' type='text/css'>
    <link href='/stylesheets/print.css' media='print' rel='stylesheet' type='text/css'>
    <link href='http://www.hazyblue.me/feed.xml' rel='alternate' title='#!/hazy/blue/. - Feed' type='application/rss+xml'>
  </head>
  <body class='bp two-col light'>
    <div id='container'>
      <div id='header'>
        <div class='title'>
          <a href='/'>
            <span id='title'>#!/hazy/blue/.</span>
            <span id='subtitle'>open to interpretation</span>
          </a>
        </div>
      </div>
      <div id='sidebar'>
        <h2>Recent Posts</h2>
        <ul>
          <li><a href="/2013/06/getting-technical/">Getting Technical</a></li>
          <li><a href="/2013/05/new-site/">New Site, New Framework</a></li>
          <li><a href="/2013/05/making-space/">Making Space</a></li>
          <li><a href="/2013/05/open-source-treks-to-the-final-frontier/">And Now You're an Anstronaut: Open Source Treks to The Final Frontier</a></li>
        </ul>
        <h2>Follow</h2>
        <a href='/feed.xml'>
          <img src='/assets/Feed-icon.svg.png'>
        </a>
        <a class="twitter-follow-button" data-show-count="false" href="https://twitter.com/hazybluedot">Follow @hazybluedot</a>
      </div>
      <div id='content'>
        <div class='post'>
          <h1>Getting Technical</h1>
          <aside>Posted on: June 8, 2013</aside>
          <article>
            <p>Some personal interests seem to wax and wane, but remain ever-present
            in my mind. Lurking. Waiting for the right moment to make you look
            back and go, ‘huh’.</p>
          </article>
        </div>
      </div>
    </div>
  </body>
</html>
~~~

There's a LOT of extra information before we even get to the article
content, and most of it is going to be the same on every page. Because
software developers are strong advocates of the DRY principal, and
computers are great at highly repetitive tasks, it is not surprising
that there are tools to assist with this clerical work. Generally,
what we would like to do here is referred to as templating. We would
like to create one template of all the boiler plate HTML that should
be included on each page, and specify place holders where actual
content will appear. Since `nanoc` is written in `ruby`, the natural
way to do this is with [Embedded Ruby][erb], or [`erb`][erb]. Let's
take a look at just the sidebar portion of the above HTML code and see
what it would look like as a template written with `erb`:

~~~ erb
<div id='sidebar'>
  <h2>Recent Posts</h2>
  <ul>
    <% sorted_articles.each do |post| %>
      <li><%= link_to post[:title], post.path %></li>
    <% end %>
  </ul>
</div>
<div id='content'>
<%= yield %>
</div>
<div id='footer'>
a dkm production
</div>
~~~

The interesting bits are the pieces of ruby code between the `<%=` and
`%>` tags. Then running these pieces of code the ruby interpreter will
replace everything between the `<%` and `%>` with the result generated
by running the code inside those brackets. Ruby is designed to be easy
to read, so without any prior experience with the language you can
easily tell that the first bit of code will generate a sorted list of
articles (the type `article` is a piece of meta data the Nanoc
Blogging Helper associates with files that should be interpreted as
blog posts, rather than regular pages), putting a link to each on in a
list item (`li`) HTML element.

This is pretty nice, I just specify that structure in a single file,
and it is used on every page I create, whether it's 1 or 100.

But I'm lazy and error prone, and want to protect against silly typos,
so I decided to use [`haml`](haml) instead of [`erb`][erb] as my
templating language. Haml uses indentation level to indicate blocks,
rather than a closing tag, so the template looks a little cleaner:

[erb]: http://ruby-doc.org/docs/ProgrammingRuby/html/web.html#S2
[haml]: http://www.haml.info

~~~ haml
#sidebar
  %h2 Recent Posts
  %ul
    - sorted_articles.each do |post|
      - if post[:published]
        %li= link_to post[:title], post.path
#content
  = find_and_preserve(yield)
#footer
  a dkm production
~~~

the structure of the generated HTML is represented by the indentation
level of each line of Haml, so it is easy by just looking at the
template to see that `sidebar`, `content` and `footer` are all the
same structural level, and the `ul` containing the list of sorted
articles is contained inside the `sidebar` section. Haml also makes a
few assumptions based on common templating patterns and will treate
`#sidebar` as a `div` element with `id` attribute equal to `sidebar`,
the equivalent of `<div id='sidebar'>` in the `erb` example. This
handy assumption helps clean up the template and save typing. Every
character I *don't* need to type is one less I could potentially make
a mistake on!

## Once more, with style

My content is written in markdown, and pages are structured with haml
templates. But what about things like fonts, colors and margins?
Continuing on the same theme, style information is stored in a
separate file and applied to each page automatically.

Cascading Stylesheets (CSS) were invented in 1994[^css]


[^1]: [A history of HTML](http://www.w3.org/People/Raggett/book4/ch02.html)
[^css]: [The CSS saga](http://www.w3.org/Style/LieBos2e/history/Overview.html)
