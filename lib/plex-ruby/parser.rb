module Plex
  class Parser

    attr_reader :parent, :node

    # @param object representing the parent of what we're trying to parse
    # @param [Nokogiri::XML::Element] nokogiri node to parse
    def initialize(parent, node)
      @parent = parent
      @node = node
    end

    # Parses a XML node and returns the structure it represents. This is
    # currently used to parse Sections as we don't know whether a Section holds
    # a list of Shows or a list of Movies.  The parsing is done recursively.
    #
    # @return [Array, Movie, Episode, Show] depending on what node it is given,
    #   will return an Array of Movies or Shows, a single Movie, and single
    #   Episode, or a single Show
    def parse
      case node.name
      when 'document'
        Plex::Parser.new(parent, node.root).parse
      when 'MediaContainer'
        parse_media_container
      when 'Video'
        parse_video
      when 'Directory'
        parse_directory
      when 'text'
        nil
      else
      end
    end

    private

    def parse_media_container
      return nil if node.attr('size').to_i == 0
      node.children.map {|m| Plex::Parser.new(parent, m).parse }.compact
    end

    def parse_video
      case node.attr('type')
      when 'movie'
        parse_movie
      when 'episode'
        parse_episode
      else
        raise 'Unsupported Video Type!'
      end
    end

    def parse_movie
      Plex::Movie.new( parent, node.attr('key') )
    end

    def parse_episode
      Plex::Episode.new( parent, node.attr('key') )
    end

    def parse_directory
      case node.attr('type')
      when 'show'
        Plex::Show.new( parent, node.attr('key')[0..-10] ) # Remove /children
      when 'artist'
        Plex::Artist.new( parent, node.attr('key')[0..-10] )
      when 'album'
        Plex::Album.new( parent, node.attr('key')[0..-10] )
      else
        raise "Unsupported Directory type #{node.attr('type')}"
      end
    end
  end
end

