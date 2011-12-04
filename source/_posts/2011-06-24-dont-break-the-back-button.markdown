---
layout: post
title: "Don't Break the Back Button"
date: 2011-06-24 21:42
comments: true
categories: 
- Usability
- Android
---

Recently, I've worked on/with or used a few Android applications that "disable"
the back button in some cases.

If you haven't used Android, the back button is a prominent feature. Nearly
every Android device has a hardware back button. The system maintains a stack of
all the activities the user has navigated to, and when the user presses the back
button, [it takes the user to the previous activity](http://developer.android.com/guide/practices/ui_guidelines/activity_task_design.html#taking_over_back_key).

This works both inside individual apps and also across process boundaries. For
example, when I'm reading an email and push the back button, I end up back at my
inbox. If I push the back button again, I'll end up at whatever app I was in
before I opened Gmail.

This functionality is all provided by the OS, so all you have to do to get it
right is to not break anything.

Nonetheless, many developers have taken it upon themselves to intercept the back
button and swallow it. Here's what this is like when you intercept the back
button on the web:

{% img /images/blog/broken-back-button.png %}

In other words, it's completely obnoxious and unacceptable. Unfortunately, it
seems that which we know to be obviously true in web development, is quickly
forgotten when it comes to a mobile device.

I remember reading about
[a study at the Rochester Institute of
Technology](http://www.mendeley.com/research/portable-eyetracking-a-study-of-natural-eye-movements/)
a few years ago, wherein researchers mounted eye-tracking devices on subjects
who were washing their hands. A very simple task: washing your hands.

What the study found was a new type of eye movement, the "planful" movement. In
short, before interacting with any object, we build a model of that interaction
in our minds and look at the object, without being consciously aware that we are
doing so. For example, your eyes and your brain are glancing at and scouting out
the paper towel dispenser while you are still rinsing your hands.

The same concept that applies to navigating your bathroom sink applies to
navigating a mobile operating system. Your app may only be displaying one
specific activity on the screen, but you can be sure that the user has
constructed a mental model of how they are going to navigate through your app,
through their device, to accomplish whatever they need to accomplish today.

Most of the time, these mental models aren't fully conscious or completely
articulated. Ask someone how they would get from Angry Birds to Gmail, and
you'll hear something along the lines of, "I'll save and back out of the game
and then open up Gmail." Their mental machinery has abstracted away the minutiae
of what they would specifically push or click on.

Instead, users just rely on their intuitive experience of how to navigate a
system. That intuitive experience makes certain assumptions regarding how this
virtual world is structured. These assumptions are often as strong as your
assumptions regarding the physical world — up is up, down is down, and if you
retrace the way you came, you'll always end up where you started.

When you break these unconscious and conscious assumptions regarding how things
work, you are basically giving your users a [mental segfault](http://xkcd.com/371/):

{% img http://imgs.xkcd.com/comics/compiler_complaint.png 'XKCD comic #371' %}

Don't break the back button.
