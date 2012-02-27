---
layout: post
title: "Fixing Thunderbolt Ethernet on the MacBook Pro"
date: 2012-02-27 12:57
comments: true
categories: 
- OS X
- MacBook Pro
- Thunderbolt
---

A few weeks ago, I had to make one of the toughest choices I've had in a while: a 30" Dell display,
or a 27" Apple Thunderbolt display. I went with the Thunderbolt display, partly because the colors
are better, but mostly for the convenience of having USB and ethernet integrated into the display.

The way this works, you can just plug your USB peripherals and your network cord into the
Thunderbolt display. Then, whenever you dock your MacBook Pro, you just connect the single
Thunderbolt cable and the display, USB devices, and network all work magically.

It's much more convenient than doing the daily morning dance of plugging four or five things into
your MacBook, and it's the closest thing we have to a good MacBook Pro dock.

Well, that's the theory anyway. In reality, while the USB works fairly decently, the ethernet
connection dropped out on day one, and I haven't been able to get it back since. Until today.

Here are the final steps that worked for me. Hopefully somebody else can save a bit of time with
this:

1. With the Thunderbolt display connected, visit the Network tab in System Preferences. If you see
   **Display Ethernet** and/or **Display FireWire** in the list of network interfaces, select each
   one and use the minus (**-**) button at the bottom of the list to remove it.

   For me, **Display FireWire** was listed, but **Display Ethernet** was not. I've heard of others
   having strange symptoms with neither or both listed.

2. Unplug the Thunderbolt display. This will not work if you keep the display plugged in while doing
   the next few steps. Trust me, I tried it.

3. `sudo rm /Library/Preferences/SystemConfiguration/NetworkInterfaces.plist`

4. Restart your MacBook Pro and log back in. Once you've logged in, connect your Thunderbolt display
   again.

5. Visit the Network tab in System Preferences again. If you see **Display Ethernet** and **Display
   FireWire** listed, you're all good. Otherwise, click the plus (**+**) button at the bottom of
   the list of network interfaces.
   
   From the **Interface** dropdown, select the interface you have missing and click **Create**. If
   you have both interfaces missing like I did, you will have to repeat this step for the other
   interface.

After all that, everything seems to be working smoothly for me.

