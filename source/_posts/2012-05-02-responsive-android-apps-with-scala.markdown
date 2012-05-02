---
layout: post
title: "Responsive Android Apps with Scala"
date: 2012-05-02 08:40
comments: true
categories: 
- Android
- Code
- Scala
---

When it comes to building responsive Android apps, there are two commandments:

1. Don't block the UI thread, ever.
2. Only access and modify the UI from the UI thread itself.

The Android Dev Guide goes into [some detail about this](http://developer.android.com/guide/topics/fundamentals/processes-and-threads.html#WorkerThreads).
The usual solutions in Java are to:

*  Spawn a thread that does work and then invoke [`View.post`](http://developer.android.com/reference/android/view/View.html#post%28java.lang.Runnable%29)
   with a [`Runnable`](http://developer.android.com/reference/java/lang/Runnable.html)
   that manipulates the UI.
*  Implement and run an [`AsyncTask`](http://developer.android.com/reference/android/os/AsyncTask.html)
   that does work in `doInBackground`, and then manipulates the UI in
   `onPostExecute`.

As you can see, both these solutions — though they are the bread and butter of
Android development — are pretty verbose and unwieldy:

{% gist 2574564 ThreadWithRunnable.java %}

{% gist 2574564 UsingAsyncTask.java %}

I prefer `AsyncTask`, which has better semantics, but implementing one
`AsyncTask` after another quickly becomes tedious. Same with writing line after
line of `Runnable` boilerplate.

Enter Scala, using either the [sbt Android plugin](https://github.com/jberkel/android-plugin)
or [my Maven-based solution](https://github.com/rohansingh/android-scala-test).

The first step is to create an implicit conversion from a function to a `Runnable`,
which can then be passed to `View.post` or `runOnUiThread`. Once we've done
that, it's simple to use `spawn` from [`scala.concurrent.ops`](http://www.scala-lang.org/api/current/scala/concurrent/ops$.html)
to do background work.

Here's a fully functional example:

{% gist 2574564 MainActivity.scala %}

This is so much nicer than the Java alternative. Instead of up to ten lines of boilerplate
for each background task, we end up with just the `spawn` and `runOnUiThread`. 

If you're waiting for that final push to switch over to Scala for your Android development,
I highly recommend the [sbt](https://github.com/harrah/xsbt/wiki) plugin for Android. Take
a look at its brilliant [Getting Started guide](https://github.com/jberkel/android-plugin/wiki/getting-started),
which will have you up and running in just a few minutes.

