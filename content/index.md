---
title: #!dkm
---

- sorted_articles.each do |post|
  - if post[:published]
    .post
      %h1 
        = link_to(post[:title], post.path)
      %aside Posted at: #{get_pretty_date(post)}
      %article
        = get_post_start(post)
