---
layout: post
title: "The Inner-Platform Effect"
date: 2012-01-09 20:45
comments: true
categories: 
- Coding
---

Today [someone on Hacker News](http://news.ycombinator.com/item?id=3442497)
posted a link to the [Wikipedia article on the inner-platform effect](http://en.wikipedia.org/wiki/Inner-platform_effect),
which is "the tendency of software architects to create a system so customizable as to become a
replica, and often a poor replica, of the software development platform they are using.

One of my favorite parts of the article (emphasis mine):

> In the database world, developers are sometimes tempted to bypass the RDBMS, for
> example by storing everything in one big table with two columns labelled key and
> value. While this entity-attribute-value model allows the developer to break out
> from the structure imposed by an SQL database, it loses out on all the benefits,
> since all of the work that could be done efficiently by the RDBMS is forced onto
> the application instead. Queries become much more convoluted, the indexes and
> query optimizer can no longer work effectively, and data validity constraints
> are not enforced. __Such designs rarely make their way into real world production
> systems, however, because performance tends to be little better than abysmal,
> due to all the extra joins required.__

Oh man, if only. I can think of at least [one example](http://www.magentocommerce.com/) of a
a platform with this very problem — and with the associated horrible performance profile — that is
very widely deployed and used in production environments around the world. I'm sure you can think of
others.
