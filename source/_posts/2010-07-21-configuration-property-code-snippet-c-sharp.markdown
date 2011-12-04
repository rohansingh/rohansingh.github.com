---
layout: post
title: "ConfigurationProperty Code Snippet (C#)"
date: 2010-07-21 16:52
comments: true
categories: 
- Code
- C#
---

If you've ever wanted to create a [custom configuration section for a .NET
app](http://msdn.microsoft.com/en-us/library/2tw134k3.aspx),
you know how tedious it is to type this out:
 
{% codeblock lang:csharp %}
namespace Samples.AspNet
{
    public class PageAppearanceSection : ConfigurationSection
    {
        // Create a "remoteOnly" attribute.
        [ConfigurationProperty("remoteOnly", DefaultValue = "false", IsRequired = false)]
        public Boolean RemoteOnly
        {
            get
            { 
                return (Boolean)this["remoteOnly"]; 
            }
            set
            { 
                this["remoteOnly"] = value; 
            }
        }

        // Create a "font" element.
        [ConfigurationProperty("font")]
        public FontElement Font
        {
            get
            { 
                return (FontElement)this["font"]; }
            set
            { this["font"] = value; }
        }

...
{% endcodeblock %}

There's a much faster way to create normal properties. If you've ever [used the
prop code snippet to create a property](http://www.onesoft.dk/post/The-prop-snippet-and-Visual-Studio-2008.aspx),
you already know this. You can just type "prop" and hit tab to have an entir
property filled out for you:

{% img /images/blog/prop-snippet.png %}

Faced with the daunting task of creating some custom configuration elements, I
threw together a code snippet that lets you do the same for a
configuration-backed property. I can now just type "propc" and hit tab to get
this:

{% img /images/blog/config-prop-snippet.png %}

Then I just fill out the name and type and call it good. If you'd like to join
in on the propc goodness here's the source of the snippet file. Just download
and save it as a **.snippet** file and import it through **Tools** |
**Code Snippets Manager** in Visual Studio:

{% gist 1410807 %}
