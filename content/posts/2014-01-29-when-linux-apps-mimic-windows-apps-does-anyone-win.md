---
title: When Linux Apps Mimic Windows Apps Are We Selling Ourselves Short?
published: true
kind: article
created_at: '2014-01-29 17:36:21 -0500'
author_name: hazybluedot
tags: linux, application design, bag-of-bytes
---

I think I understand *why* there is a prevalence of very non-Unixy
applications such as integrated WYSISYG word processors, presentation
tools, IDEs, etc. Presumably it helps potential Windows converts feel
more comfortable. "Oh, this isn't all that different than I'm used
to".  But if in the case that "different" means "better", I wonder if
we could be doing more than just making people feel
comfortable. Really, they should feel "oh, this is much better".

<!-- more -->

My mother is a success story of the "this is just what I'm used to"
philosophy. I installed Fedora Linux on her computer over winter break
and it only took a few minutes to show her that copying files from USB
drives, starting a web browser and starting a wordprocessor or
spreadsheet program worked just the way she was used to on Windows and
MS tools.

So far so good.  Until today she called me up with a problem. A
document she had created in AbiWord on Linux wouldn't open in MS Word
on her work computer. Not terribly surprising there, I figured it
would just be a matter of having her "save as" back on AbiWord and
selecting the Word Document format.  Things got interesting though
when she attempted to open the original file back in AbiWord and it
was "gibberish", which I have learned over the years is what normal
people call XML. Understandably confusing to a non-techy user who just
wants to open a document. After sharing the file with me I confirmed
the same results, AbiWord opened the file as plain text, displaying
the raw XML, even though the content of the XML clearly indicated it
was an AbiWord file.

Then I noticed that the extension of the file was `.doc`. On a hunch,
and quietly thinking to my self "oh, don't you dare, AbiWord", I
renamed the file with a `.abw` extension, reopened and voila!
Everything fixed.  I could then "save as" into word format and
everyone was happy.

To a windows power user this shouldn't seem like such a big idea. File
name extension determines file type and Windows apps are notorious for
claiming they don't know how to open a particular file just if the file
name doesn't end in an extension they're expecting. So why would
AbiWord (or LibreOffice writer, haven't checked that yet) behave any
different?

Because Unix traditionally doesn't give a hoot about file
extensions. It figures a user should be able to name a file whatever
the hell they want, the type of content is determined by the content
itself.  And indeed, the system can easily distinguish between the two
file types

    $ file 2014-01-27.doc
    2014-01-27.doc: Rich Text Format data, version 1, ANSI
    $ file 2014-01-27.abw
    2014-01-27.abw: XML document text

regardless of file extension

    $ mv 2014-01-27.doc 2014-01-27.poodle
    $ mv 2014-01-27.abw 2014-01-27.greyhound
    $ file 2014-01-27.poodle
    2014-01-27.poodle: Rich Text Format data, version 1, ANSI
    $ file 2014-01-27.greyhound
    2014-01-27.greyhound: XML document text
    
And when you think about it, I mean really think about it, is it at
all intuitive that the name of a file should have any affect on how
the content is interpreted?

What bugs me about this is that it seems like mimicking bad behavior
for no good reason. Clearly in this case the familiar behavior didn't
give my mother any hints about how to resolve the problem herself. And
it is clearly within AbiWord's power to do the right thing: check the
mime-type of the file, if it's XML then use the `!DOCTYPE` to
determine how to interpret it (that's the whole point of using XML as
a portable document format, after all, is it not?), and if it's
something else, then act accordingly (I don't know enough about the
Rich Text format... is Rich Text just one kind of format, or could it
be interpreted multiple ways?)

I don't know how my mother ended up giving an AbiWord XML document a
`.doc` extension to begin with, but it doesn't help that the "save as"
interface allows one to select a format and then provide whatever
extension the user wants, even though the application itself is
sensitive to the choice.

Consider a more Unixy implementation of AbiWord (for a moment let's
disregard the fact that confounding a document's content with its
style in a WYSIWYG editor is arguably anti-Unix also) and how this
scenario would have played out.  Once she realized that her `.doc`
wasn't displaying correctly in MS Word my mother would go back and
reopen in AbiWord.  Even though the file has a `.doc` extension,
AbiWord checks the mime-type, recognizing the file as XML, detects the
AbiWord dtd and renders it properly.  My mother than goes to "save as"
and saves as a MS Word document, goes back to her work computer and
opens it without a hitch. No tech-support calls to me (not that I mind
chatting with my mother, it's always a pleasure :-) ), she probably
won't appreciate the fact that AbiWord did some intelligent deduction
that wouldn't have happened on a Windows app, but content is better
than frustration caused by this strange new system NOT working and
displaying her document in a form different from how she saved
it. Even though that's how Windows apps would handle it anyway.

Of course, the beauty of AbiWord and the being open source I or
someone else could go in there and implement a decent mime-type check
and solve this problem. The fact that no one has leads me to believe
that the general consensus in the windows->linux application port
community is that consistency rules, even when it means bad
functionality.
