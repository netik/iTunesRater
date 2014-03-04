iTunesRater
===========

Cocoa+Applescript dialogbox to quickly go through your catalog and rate it.
Great for use with things like the SXSW Torrent (www.sxswtorrent.com) and other times when you need to rate a ton of music, really quickly.

What this code does is the following:

* You play your iTunes catalog
* Fire up the software
* You click a box to rate something to 0,1,2, or 3 stars. It will also set the song's genre. 

There's also keyboard shortcuts!

* right arrow - next song
* left arrow - previous song
* space - skip 15 seconds
* Number keys (not keypad keys):
** 0 - rate "no play"
** 1 - rate 1
** 2 - rate 2
** 3 - rate 3

All of this is done by having Cocoa call Applescript to talk to iTunes. At some point, I should probably rewrite this thing to use the scripting bridge. Oh well, thsi works. 

Setting a song to 0 stars will also set the song to be 'disabled' (unchcked) in the iTunes dialog.

I use this to go through the SXSW torrent. Use at your own risk.

Thanks to jwz for the Applescripts.
Tested with iTunes 11.0.2 and Mac OS X 10.9.2. Compile target is set for > 10.8
