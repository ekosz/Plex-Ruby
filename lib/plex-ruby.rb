require 'nokogiri'
require 'open-uri'
require 'cgi'

module Plex

  # Converts camel case names that are commonly found in the Plex APIs into
  # ruby friendly names.  I.E. playMedia -> play_media
  #
  # @param [String] camel case name to be converted
  # @return [String] snake case form
  def self.snake_case(string)
    string.gsub(/::/, '/').
    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    tr("-", "_").
    downcase
  end

  # The base url of the Plex Media Server, I.E. 'http://localhost:32400'
  # !WARNING! This method will most likely be replaced in future versions
  #
  # @return [String] bases url of the Plex Media Server
  def self.url
    @@base_url
  end

  def self.url=(val)
    @@base_url = val
  end

end

require 'plex-ruby/parser'
require 'plex-ruby/server'
require 'plex-ruby/client'
require 'plex-ruby/libary'
require 'plex-ruby/section'
require 'plex-ruby/video'
require 'plex-ruby/media'
require 'plex-ruby/part'
require 'plex-ruby/stream'
require 'plex-ruby/tags'
require 'plex-ruby/show'
require 'plex-ruby/season'
require 'plex-ruby/episode'
require 'plex-ruby/movie'

