---
layout: post
title: "Posting JSON with jQuery"
date: 2011-02-22 22:23
comments: true
categories: 
- Code
- jQuery
- JavaScript
---

Lately, I've been a big fan of JSON via HTTP POST to send data to a Web service.
It's awesome for a bunch of reasons:

*   **Works equally well for simple and complex data.** Regular HTTP POST works great
    for simple data, but gets unwieldy for anything hierarchical. XML works for
    complex data, but is too wordy for something simple.

*   **Compact and human-readable.** Really, this just comes with the territory when
    you're using JSON for anything.

*   **Easy to debug using Fiddler or related tools.** You just have to type in or
    modify a JSON string when you want to do some ad-hoc testing.

*   **Easy to add support for to any server.** In fact, support for receiving JSON
    POST is built into the latest versions of
    [CherryPy](http://docs.cherrypy.org/dev/refman/lib/jsontools.html) and
    [ASP.NET MVC](http://msdn.microsoft.com/en-us/library/system.web.mvc.jsonvalueproviderfactory.aspx).

That said, JSON POST still doesn't seem to be all that popular compared to
an old-style URL-encoded HTTP POST. One explanation I've heard proposed for
this is the lack of support in jQuery. By default, jQuery goes with the
old-style POST. You know:

    foo=bar&abc=xyz&x=123

Sure, you can pass in a complex type and jQuery will gladly serialize it
into this format for you, but good luck trying to read that with your human
eyes, or trying to piece it back together on the server in any sane way.

The really sad thing is that jQuery has a great `getJSON()` function that lets
you receive JSON output and parses it appropriately. But there is no
built-in support for posting raw JSON.

To that end, I threw together this little plugin that I use all over the
place:

{% codeblock lang:js %}
  jQuery.extend({
    postJSON: function(url, data, callback) {
      return jQuery.ajax({
        type: "POST",
        url: url,
        data: JSON.stringify(data),
        success: callback,
        dataType: "json",
        contentType: "application/json",
        processData: false
      });
    }
  });
{% endcodeblock %}
