iTunesRater
===========

Cocoa+Applescript dialogbox to quickly go through your catalog and rate it.
Great for use with things like the SXSW Torrent (www.sxswtorrent.com) and other times when you need to rate a ton of music, really quickly.

[NoiNote: I decided that on my little MBP13(classic) that a huge window was in the way. Also, I wanted it to work with music I had listened to, genre-fied and previous rated so I could see if I should bump things up or down or if the genre was wrong. So I made tweaks like a tiny window with genre & rating, and also allowed 3.5 ratings that didn’t have to skip, etc.]

What this code does is the following:

* You play your iTunes catalog
* Fire up the software
* You click a box to rate something to 0,1,2, or 3 stars. It will also set the song's genre. 

There's also keyboard shortcuts!

* right arrow - next song
* left arrow - previous song
* space - skip 15 seconds
* 0 - rate "no play"
* 1 - rate 1
* 2 - rate 2
* 3 - rate 3

I'm sorry the genres are so strange. 
I don't like some genres, so I've just not added buttons for them.
[NN: Added the genre buttons I wanted…]

All of this is done by having Cocoa call Applescript to talk to iTunes. At some point, I should probably rewrite this thing to use the scripting bridge. [NN: Meh, not a biggy, maybe if I get enough free time—yeah right!] Oh well, this works. 

Setting a song to 0 stars will also set the song to be 'disabled' (unchecked) in the iTunes dialog.

I use this to go through the SXSW torrent. Use at your own risk.

Thanks to jwz for the Applescripts.
Tested with iTunes 11.0.2 and Mac OS X 10.9.2. Compile target is set for > 10.8
[NN: …changed to 10.9. Can probably roll back if needed.]
Footnote
==============

My review process, let me show you it. 

1. Download hundreds of songs.
2. Put them into iTunes.
3. Rate them from 0-3 and fix genres, as needed. (I never give a track a 3 or better on the first listen.)
4. Go back, and listen to the tracks again that you've rated at 3. 
5. Mark them 4 or 5 if they are really, really great. 

[NN: I agree with this process now, even with genres I like. So, might make 4noskip and 5noskip scripts (which would allow re-rating while listening—like when I though a track was cool, but it goes on too long and becomes to repetitive. I had to tweak the main apple script to toss the next track into the IF test, BTW, to avoid skipage.]
