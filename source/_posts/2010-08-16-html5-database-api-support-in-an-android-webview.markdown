---
layout: post
title: "HTML5 Database API Support in an Android WebView"
date: 2010-08-16 22:06
comments: true
categories: 
- Code
- Android
- HTML5
---

Here are some facts:

1. HTML5 has a [Database API](http://html5demos.com/database) that lets you
store things locally and retrieve them with SQL queries.
2. Android lets you embed a [WebView](http://developer.android.com/reference/android/webkit/WebView.html)
in your application to display web content.
3. How to combine #1 and #2 is extremely poorly documented.

One thing that kills me about the Android documentation is how it's so
hit-or-miss. Some things are so well documented that I have literally been able
to copy code out of the docs into my code and just change it a little. Actually,
my roommate saw me do this at one point and accused me of plagiarism. But that
is the subject of another post entitled "Why You Shouldn't Take Coding Advice
From Psychology Majors".

But really, I think the #1 best thing you can do when releasing a platform or
public API of any sort is include tons of samples, inline with the
documentation. The real winners when it comes to doing this are the
[PHP documentation](http://us.php.net/manual/en/function.levenshtein.php) and the
[MSDN .NET Framework documentation](http://msdn.microsoft.com/en-us/library/hs600312.aspx).
Almost every single class and function in the docs for these platforms includes
a sample of how to use the thing.

Maybe it's not a coincidence that PHP and .NET are so popular?

It took me way too long to find out how to enable HTML5 Database API support for
content displayed inside a WebView on an Android. The pieces were scattered all
over the Intertubes, though I finally found the last piece of the puzzle on
[Joe Bowser's blog](http://blogs.nitobi.com/joe/2009/11/05/how-to-implement-html5-storage-on-a-webview-with-android-2-0/).
Here's the entire thing put together:

{% codeblock lang:java %}
WebSettings settings = myWebView.getSettings();
settings.setJavaScriptEnabled(true);
settings.setDatabaseEnabled(true);

String databasePath = this.getApplicationContext().getDir("database",
    Context.MODE_PRIVATE).getPath();
settings.setDatabasePath(databasePath);

myWebView.setWebChromeClient(new WebChromeClient() {
    @Override
    public void onExceededDatabaseQuota(String url, String databaseIdentifier, long currentQuota, long estimatedSize,
        long totalUsedQuota, WebStorage.QuotaUpdater quotaUpdater) {
        quotaUpdater.updateQuota(estimatedSize * 2);
    }
});
{% endcodeblock %}

Note that the `onExceededDatabaseQuota` is mandatory. I am pretty sure the default
quota is zero, so you need to override this method and provide a quota to allow
storage. I'm using `estimatedSize * 2` as the new quota since my app is browsing
to a known page that only stores a small amount of data. Your scenario may be
different.
