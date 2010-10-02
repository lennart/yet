#!/usr/bin/env ruby

require 'rubygems'
require 'nokogiri'

def read
  path = File.expand_path("~/Music/iTunes/iTunes Music Library.xml")
  doc = Nokogiri::XML::Reader(File.new path)
  @not_quite_json = {}
  doc.each do |node|
    puts "The State is: #{@state}"
    send :"catch_#{node.name}", node
  end
  @not_quite_json
end

def catch_dict node
  case @state
  when :track
    puts "Track"  
  when :tracks
  when :track_key
    puts "#{node.name} with #{node.inner_xml}"
  else
    @state = :global_dict
  end

end

def catch_array node
  case @state
  when :track
    @state = :global_dict
  end
end

def catch_key node
  case @state
  when :global_dict
    if node.inner_xml && node.inner_xml.strip == "Tracks"
      @state = :tracks
    end
  when :track
    @key = node.inner_xml.strip
    @state = :track_key
  when :tracks
    unless node.inner_xml.strip.empty?
    @track_id = node.inner_xml.to_sym
    @not_quite_json[@track_id] ||= {}
    @state = :track
    end
  end
end

def method_missing id, *args
  if /\Acatch_/ =~ id.to_s
    case @state 
    when :track_key
      unless (node = args.shift).inner_xml.strip.empty?
        @not_quite_json[@track_id][@key] = case node.name
                                           when :integer
                                             node.inner_xml.strip.to_i
                                           else
                                             node.inner_xml
                                           end
        @state = :track
      end
    else

    end
  else
    super id, *args
  end
end
