---
layout: post
title: "Getting ASP.NET to play nice with Opera &amp; wget"
date: 2011-03-28 15:43
comments: true
categories: 
- Code
- ASP.NET
---

A few weeks ago we noticed an issue with some crawlers and search engines being
unable to crawl [Starbucks.com](http://www.starbucks.com). Around the same time,
[Karl Dubost](http://my.opera.com/karlcow/) from Opera discovered that
[visitors using Opera were getting a parse error](http://my.opera.com/karlcow/blog/2011/03/03/wrong-to-be-right-with-xhtml).
In fact, a number of high-profile ASP.NET sites seem to be impacted by the latter issue.

If you're just looking for the quick fix, skip ahead to the bottom of this post.

To sum up the issue, our server was responding with a `Content-Type` header of
`application/xhtml+xml` to both Opera and `wget`. In Opera, this triggers an XML
parser, which would fail since our content is actually `text/html`.

Of course, nowhere in our code were explicitly setting the `Content-Type` header
to anything other than `text/html`, so the behavior was puzzling. Additionally,
the server was responding with an `application/xhtml+xml` type even when the
Accept header from the browser specified `*/*`. This made no sense at all, since
if the browser was willing to accept anything, we should be sending the content
in its default `text/html`.

ASP.NET Browser Detection
-------------------------
As it turns out, ASP.NET has a somewhat questionable
[feature that allows you detect browser types and capabilities](http://msdn.microsoft.com/en-us/library/3yekbd5b.aspx),
largely based on the browser's request headers. This is mediated through a
[browser definition file](http://msdn.microsoft.com/en-us/library/ms228122.aspx)
(\*.browser), which is just a bunch of XML that matches up request header
patterns to browser types and know capabilities. This file lives in your
ASP.NET applicaiton's App\_Browsers folder.

The known capabilities for the current user agent are all available through the
`HttpContext.Request.Browser` object.

As I said, all very questionable. The idea of having a giant database of
browsers and what they are like just rubs me wrong and strikes me as
unmaintainable. In fact, we only tried out the whole browser definition file as
part of a proof-of-concept for some mobile pages. The feature never quite worked
correctly, so we abandoned it and thought that was the end of that.

The insidious preferredRenderingMime
------------------------------------

Of course, that wasn't the end of that. For each browser definition in a browser
definition file, you can define a `preferredRenderingMime` value for a browser.
For example:

    <capabilities>
      <capability name="preferredRenderingMime" value="application/xhtml+xml" />
    </capabilities>

Most of the larger \*.browser file compilations floating around the Web have
Opera set to preferring a MIME type of `application/xhtml+xml`. A lot of files
will default to a preferred type of `application/xhtml+xml` for all browsers that
pass an Accept: */* request header.

And even though we use ASP.NET MVC and no longer are using any of the browser
detection stuff at all, the System.Web.UI.Page class has this fun code that runs
when the page is processed:

{% codeblock lang:csharp %}
private void SetIntrinsics(HttpContext context, bool allowAsync)
{
    ...

    HttpCapabilitiesBase browser = this._request.Browser;
    this._response.ContentType = browser.PreferredRenderingMime;

    ...
}
{% endcodeblock %}

Brilliant, right? Since Opera prefers XHTML, this code does you the favor of
automatically setting your response content type to `application/xhtml+xml`. Of
course, since your actual content is still HTML, this causes an XML parse error
and all your Opera visitors are hosed.

This might make sense if you are doing the classic ASP.NET Web Forms thing with
server controls that adapt their rendering based on the browser's preferred
MIME. But even if you are using ASP.NET MVC, your .aspx views are still
essentially pages, and this old code will still run.

Broken `wget`
-------------
Unfortunately, this `SetIntrinsics` code has another nasty side effect. If your
application has already sent out response headers or content, it will just throw
an exception since `Response.ContentType` can't be set after response headers have
already been sent.

In the case of Starbucks.com, this meant that issue wasn't just that Opera
visitors experienced a parse error, but that an exception would be thrown for
any browser for which ASP.NET tried to switch the `Response.ContentType`. This
would result in absolutely no content being served, resulting in a blank page
for Opera visitors.

Furthermore, a large percentage of crawlers and search engines use `wget` to
grab pages. `wget` sends an `Accept` header of `*/*`, and runs into the same
no-content issue. A fine mess all around.

The fix
-------
The simplest fix, of course, is to get rid of any \*.browser files you may be
using in your application. I understand redirecting to a mobile version of your
site for mobile browsers or the like, but basing any major functionality on
guesses about the user's browser is a great path to future pain.

If, however, you want to keep your browser definition files around, consider
removing any uses of the `preferrendRenderingMime` capability. Here's a regex that
should be able to find those instances for you:

    ^.+"preferredRenderingMime".+$

Just do a find & replace on that and you should be good to go. This is what we
ended up doing for [Starbucks.com](http://www.starbucks.com) and
[Starbucks.co.uk](http://starbucks.co.uk), which I'm happy to say now
work perfectly for Opera and `wget` users alike!
