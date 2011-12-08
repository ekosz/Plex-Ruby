require 'nokogiri'
require 'open-uri'
require 'cgi'

module Plex

  # Converts camel case names that are commonly found in the Plex APIs into
  # ruby friendly names.  I.E. <tt>playMedia</tt> -> <tt>play_media</tt>
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

end

require 'plex-ruby/parser'
require 'plex-ruby/server'
require 'plex-ruby/client'
require 'plex-ruby/library'
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

