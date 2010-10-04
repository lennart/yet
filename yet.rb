#!/usr/bin/env ruby

require 'rubygems'
require 'osx/plist'
require 'yajl'

class Time
  def to_rfc3339
    self.strftime "%Y-%m-%dT%H:%I:%SZ"
  end
end

class Yet
  def plist
    @plist ||= OSX::PropertyList.load_file File.expand_path("~/Music/iTunes/iTunes Music Library.xml")
  end

  def json
    plist["Tracks"].map do |key, track|
      {
        "id" => track["XID"] || track["Persistent ID"],
        "title" => track["Name"],
        "artist" => track["Artist"],
        "track" => track["Track Number"],
        "album" => { 
          "name" => track["Album"],
          "tracks" => track["Track Count"],
          "released" => Time.utc(track["Year"] || 1970).to_rfc3339
        },
        "tags" => [track["Genre"]].compact,
        "url" => track["Location"],
        "added" => Time.new.to_rfc3339
        
      }
    end
  end
end
