But I think nobody parsed the iTunes XML Library formed JSON documents to put into a CouchDB…yet

…probably

# so let's start! 

we'll sneak through the XML jungle and strip the bloat off.
make stuff like this:

    {
      "id" : «this_will_probably_be_the_XID_of_the_song»,
      "title" : "not ready, yet",
      "artist" : "eels",
      "album" : "beautiful freak",
      "tags" : ["independent", "rock", "music"],
      "url" : "file:///Users/lenni/Music/iTunes/…you know how this ends"
    }

period
