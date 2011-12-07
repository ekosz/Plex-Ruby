module Plex
  class Parser

    attr_reader :node

    def initialize(node)
      @node = node
    end

    def parse
      case node.name
      when 'document'
        Plex::Parser.new(node.root).parse
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
      node.children.map {|m| Plex::Parser.new(m).parse }.compact
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
      Plex::Movie.new( node.attr('key') )
    end

    def parse_episode
      Plex::Episode.new( node.attr('key') )
    end

    def parse_directory
      case node.attr('type')
      when 'show'
        Plex::Show.new( node.attr('key')[0..-10] ) # Remove /children
      else
        raise "Unsupported Directory type #{node.attr('type')}"
      end
    end
  end
end

