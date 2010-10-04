But I think nobody parsed the iTunes XML Library formed JSON documents to put into a CouchDB…yet

…probably

# so let's start! 

we'll sneak through the XML jungle and strip the bloat off.
make stuff like this:

    {
      "id" : «this_will_probably_be_the_XID_of_the_song»,
      "title" : "not ready, yet",
      "artist" : "eels",
      "track" : 2,
      "album" : {
        "name" : "beautiful freak",
        "tracks" : 10,
        "released" : "2006-02-17T20:00:00Z"
      }
      "tags" : ["independent", "rock", "music"],
      "url" : "file:///Users/lenni/Music/iTunes/…you know how this ends"
      "added" : "2010-05-17T13:53:18Z"
    }

period
