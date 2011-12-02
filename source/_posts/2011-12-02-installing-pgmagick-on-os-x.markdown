---
layout: post
title: "Installing pgmagick on OS X"
date: 2011-12-02 08:18
comments: true
categories: 
---

[pgmagick](http://pypi.python.org/pypi/pgmagick/) is a Python wrapper for
for [ImageMagick](http://imagemagick.org/) (or
[GraphicsMagick](http://graphicsmagick.org/)). I needed it for something I was
trying to run yesterday, but the instructions for OS X seem to have gotten lost
in the depths of the Internet.

I'm assuming you have a working [Homebrew](http://mxcl.github.com/homebrew/),
Python, and [`pip`](http://pypi.python.org/pypi/pip). You'll also need
[my Homebrew formula for Boost](https://github.com/rohansingh/homebrew/blob/master/Library/Formula/boost.rb).

Once you've got that, it's pretty straightforward:

    $ brew install imagemagick --with-magick-plus-plus
    $ brew install boost --with-thread-unsafe
    $ pip install pgmagick

Try it out and it should work:

    $ python
    Python 2.7.2 (default, Oct 20 2011, 17:33:50) 
    [GCC 4.2.1 (Based on Apple Inc. build 5658) (LLVM build 2336.1.00)] on darwin
    Type "help", "copyright", "credits" or "license" for more information.
    >>> import pgmagick
    >>> pgmagick.gminfo.library + ' ' + pgmagick.gminfo.version
    'ImageMagick 6.x.x'

For extra credit, you should also be able to install the
[Python Imaging Library (PIL)](http://www.pythonware.com/products/pil/)
as well:

    $ pip install -f http://effbot.org/downloads Imaging==1.1.7
