---
layout: post
title: "4 Simple Rules for Catching .NET Exceptions"
date: 2010-09-13 16:58
comments: true
categories: 
- Code
- .NET
---

What follows has probably been expounded a thousand times in different places.
In fact, MSDN even has a long article entitled
[Best Practices for Handling Exceptions](http://rrs.co/aMavUs).

That said, I believe the best practices when it comes to catching .NET
exceptions can be boiled down into four basic rules:

1.  Do not catch an exception unless you have something specific you need to do with
    that exception in the place you are catching it. Generally, there’s two
    scenarios where it’s alright to catch an exception:

    1. When you can do something specific to respond to and recover from a specific
    exception.
    2. When you have specific logging or, in the UI, want to display a specific error
    message due to a specific exception.

    Every exception and every catch block incurs a major performance overhead. If
    you can’t do something that fits into one of these two categories, you generally
    should not catch the exception. Note that this means that catching `Exception`
    instead of a specific type of exception is almost never correct.

2.  When you want to convert an exception to a string for logging, just use
    `ex.ToString()`. Do not try to `ToString()` or do any complex operations on any of
    the exception's other properties in a way that could fail if those properties are
    null. For example, `ex.SomeProperty.ToString()` is almost never correct since
    `SomeProperty` might be null. Even if it seems to not be null when you are
    testing, since this is by definition an exceptional case you can’t be sure what
    properties of the exception may or may not be filled.  

    More generally, avoid doing things in a catch block that may cause another
    exception to be thrown. Don’t nest try-catch blocks.

3.  Never do anything that would hide an exception from bubbling up unless you have
    specific code that can recover from the exception. For example, even if you are
    logging an exception in your catch block, rethrow it so any logging code higher
    up will be able to process it as well.
    
    The only time you should not rethrow an
    exception is when you can recover from it and the code can keep running fine.
    
    That said, if you can recover from an exception and the code can keep running,
    see if it would be possible to predict the exception beforehand and avoid it. As
    an example, say you are going to try to call `ToUpper()` on a string. If the
    string is null beforehand, you already know that a null reference exception will
    be thrown, so don’t call `ToUpper()`.

4.  When you rethrow an exception, always just use `throw;`. Do not use `throw ex;`.
    The latter restarts the call stack and makes debugging much more difficult. The only
    time you would do the latter is if you want to hide internals for some reason
    like security, which is almost never needed.

Comments? Concerns? Death threats?
