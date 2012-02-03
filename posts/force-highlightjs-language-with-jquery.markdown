---
title: Force highlight.js language with jQuery
tags:
  - syntax
  - jquery
  - javascript
  - markdown
  - quickie
date: 2012-02-03 20:00:00
---

[highlight.js](http://softwaremaniacs.org/soft/highlight/en/) is a handy syntax highlighter when writing in Markdown as it allows you to highlight pre tags without the need to have a class attribute (very difficult in Markdown). It's _usually_ clever enough to understand what language the code is written in and assign a class accordingly. But it's not fullproof and sometimes (only sometimes) gets it wrong.

So here's a small snippet of jQuery to fix that. It looks for `<pre><code>` tags. If it includes a specific identifier `~~lang` it will set the class to that language. So if it's ruby code add `~~ruby` etc. 

As you can see it's a little bit more complicated than that. I was having trouble removing the current class then adding a new class to the tags, so I had to use the messy task of duplicating the code below the element and then deleting the original. Like I said, messy, but it works. 

    ~~javascript
    $("pre > code").each(function(){
      var lang = $(this).text().match(/~~(\w+)/);
      if (lang) {
        var content = $(this).html().replace(/~~(\w+)/, "").substr(1);
        var new_pre = "<pre><code class=\"" + lang[1] + "\">" + content + "</code></pre>";
        $(this).parent().after(new_pre);
      }
    });


