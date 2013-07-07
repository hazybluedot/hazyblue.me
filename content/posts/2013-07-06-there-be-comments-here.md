---
title: There be comments here!
published: true
kind: article
created_at: '2013-07-06 16:14:37 -0400'
tags:
  - nanoc
  - ruby
  - static site generator
  - static comments
  - blogging
  - meta
---

My conversion to the dark side of blogging is nearly complete. I've
just about worked out all the details involved with dealing with
comments. You may have already noticed the shiny new comment submission
form at the bottom of the page. I still don't quite know how to style
it so the fields line up nicely, but it's functional.

TL;DT: [show me the code](#source-files)

<!-- more -->

## Backstory

Blogs are comprised of mostly static content and so there are a number
of benefits to deploying them as static websites, some of which I
outlined in a [previous post](/2013/05/new-site/). Well, static in the
sense that content *usually* only changes when the author changes it,
so incorporating a one-off compile and deploy step to the authors
work-flow is no big deal. The major exception of course are user
comments. The most popular solution for implementing comments on a
mostly static site is to use
[a third party service](http://www.hongkiat.com/blog/3rdparty-comment-discuss-systems-reviewed/),
such as [Disqus](http://disqus.com/). There are a number of reasons this may not be desirable:

1. These services depend on Javascript to work and involve dynamically
   rewriting page content. While not a major show stopper, some people
   prefer to disable javascript for a variety of reasons. I am not
   morally opposed to using Javascript on my page, but would prefer to
   use it only when absolutely necessary with graceful fallback on
   browsers that have javascript disabled.
2. Comment data is stored on servers different from the main page
   content. Servers that are controlled by the third party. For one,
   this incurs the minor overhead of requiring an additional HTTP
   request when loading the page which can slow down load time. More
   of an issue I think, is the issue of control, neither the site
   author or the reader leaving a comment have complete control over
   their data which is subject to the privacy policy of the third
   party service which may change without notice. While this is
   nothing new in the era of cloud computing and ubiquity of social
   networks, it is a mess I'd rather avoid.
3. Most of the popular systems I've come across are closed source. I'm
   not necessarily dogmatic in my preference for open sourced
   solutions, but make an effort to use open source software when
   possible.

Issues 1 and 2 can contribute to slower page load times, mitigating
some of the benefits of creating an all-static site in the first
place, while 2 and 3 have more philosophical implications. Luckily
there is a simple, elegant solution that fits nicely into the
static-site work-flow with only slightly more work for the site
maintainer. Static comments. The general idea is that with a little
extra work, comments end up as regular files in the same directory
structure as the rest of the content for the site, and so get
incorporated naturally with whichever static site generator is used
(in my case, [nanoc](http://www.nanoc.ws)).

## Implementation

Solving the problem is then easily broken into two parts.

1. Assuming comments exist as regular local files alongsite the main
content, how are the actually included in each page when the site is
build.
2. How do we get the data submitted via a form by a user into a local
   file that our site-generator can see?

Lucky for me, both of these problems had already been
[solved by Matt Palmer](http://hezmatt.org/~mpalmer/blog/2011/07/19/static-comments-in-jekyll.html)
for use with [Jekyll](http://jekyllrb.com/). The only thing I had to
do was adapt his solution for use with nanoc.

### Displaying comments stored as local files

Being a n00b both to Ruby and nanoc, my first solution comprised of
using [Matt's code](https://github.com/mpalmer/jekyll-static-comments)
almost verbatim. The only change I wanted to make was parsing files in
nanoc's mixed YAML/regular content format. It turned out the code that
actually did that was buried in a protected method in
[Nanoc::DataSources::Filesystem](http://nanoc.ws/docs/api/Nanoc/DataSources/Filesystem.html)
and was only run with a call to higher level functions that loaded a
[Nanoc::Item](http://nanoc.ws/docs/api/Nanoc/Item.html). I had
somewhat irrationally concluded that a comment wasn't really an "item"
in the same sense as other Nanoc Items, and ended up copying the
relevant parsing code into my own comment loading solution. This of
course was a direct violation of the DRY principle which didn't stop
bugging me until I came to my senses and embraced Nanoc's Item
loader. The result pretty much ditched all but a glimmer of Matt's
original code, but ended up being super simple:

~~~~ ruby
module Nanoc::Helpers
  module StaticComments
    # Find and return all the comments for a post
    # @param [Nanoc::Item] the nanoc item used to match comments to
    # @return [Array<Nanoc::Item>] The comments for the supplied item, if any    
    def comments_for_post(post)
      comments = @site.items.select { |item| item.identifier =~ /^\/comments\// and item[:post_id] == post.identifier }
      comments.sort_by { |a| attribute_to_time(a[:created_at]) } 
    end

  end
end
~~~~

Just a fairly straight forward `select` and `sort_by` on the items
array. The
[source is available](https://github.com/hazybluedot/hazyblue.me/blob/master/lib/comments.rb)
on github. The trick to the simplicity is just storing the comments
under the Nanoc site's `content` directory (in this case in
`content/comments`) so that each comment is loaded as a Nanoc::Item
automatically. A very nice side-effect of this approach is now I can
add a `compile` entry in `Rules` to filter the comments in a special
way. Currently, I'm just treating comments as Markdown, so they are
filtered using the default compile Rule use for all content, but it
would be a stretch to imagine a situation in which someone might want
to handle comment compilation differently.

Normally each nanoc Item gets mapped to a unique url in the final
site. In my case, I didn't want to generate a separate page for each
comment, so I just added a route rule to not route anything in
`/comments/`:

~~~ ruby
route '/comments/*/' do
  nil
end
~~~

The only remaining piece is to get the comments included in the actual
posts. This was done by adding a few lines to my haml template:

~~~ haml
    %footer
      .twitter_image_text
        %a{:href => tweet_this_url(item), :target => '_blank'}
          %img{:src => '/assets/twitter-bird-light-bgs.png', :width => '32'}
          Tweet This
        #comments
          = "#{item.comments.length} comments on #{item[:title]}"
          - item.comments.each do | comment |
            %article.comment
              %header
                .vcard
                  %span.photo
                    = gravatar_image_for_comment(comment)
                  %span.fn
                    = comment_author_link(comment)
                  on 
                  %time{:pubdate => true, :datetime => get_pub_datetime(comment)}
                    = attribute_to_time(comment[:created_at]).strftime('%B %-d, %Y at %l:%M %P')
                  said: 
              = comment.compiled_content
~~~

The `Item#compiled_content` method unsuprisingly returns the content
filtered by whichever filters were set in the `Rules` file, so the
decision to parse comments as Markdown is nicely encapsulated in one
place. The alert reader will not that I don't actually make a call to
my aforementioned `comments_for_post` function. This is because I
utilized Ruby's rather nifty ability to dynamically crack open and
modify any class, even library classes like `Nanoc::Item`. After
the `StaticComments` definition in my `comments.rb` I added the
following few lines:

~~~ ruby
include Nanoc::Helpers::StaticComments

module Nanoc
  class Item
    # @return [Array<Nanoc::Item>] The comments for this item, if any
    def comments
      comments_for_post(self)
    end
  end
end
~~~

and viola, now I can access the comments for a particular page simply
by calling the `Item#comments` method. I may end up creating a
`Comment` class, subclassing `Nanoc::Item`, to make the results of
`comment_author_link` and `gravatar_image_link` accessible as method
calls as well, but I haven't decided if this would necessarily be a
good thing quite yet.

### Processing form data

By it's nature this this step requires a bit of server-side
code. Tomas Carnecky has written about
[his own solution](https://blog.caurea.org/2012/03/31/this-blog-has-comments-again.html)
making clever usage of a `mailto` link which even bypasses this
requirement. I really like the simplicity of using `mailto` and
eliminating the server from the comment loop altogether, but it
depends on the user having properly configured their browser to open
their prefered mail client when clicking a `mailto` link. Even if this
has been configured, this fragments the user experience as they are
swooshed off to a different application (or at the very least, a
different page if they have configured a webmail provider as their
default mail client). So at least for the time being, I opted for teh
not-completely-static-but-still-pretty-darn-close solution of dropping
a simple PHP script on my server that formats the comment form
submissions into a nice email to me. Because all comments are
ultimately submitted via email (even if that step is hidden from the
user), I hand moderate all submissions, and benifit from my email
system's anti-spam filtering. Saving that email to a file in my site's
`content/comments` and issuing a `nanoc compil` and `nanoc deploy`
command is all it takes to get the shiny new (and approved) comment
published. At somepoint I'll probably automate this step to so that it
is accomplished by a single command from my mail client.

## Source Files

The entire set of source files for this site are
[on github](https://github.com/hazybluedot/hazyblue.me/). Relevent
files for static comment implementation are `lib/comments.rb` and
`layouts/post.haml`.
