module Plex
  class Movie

    attr_reader :key

    def initialize(key)
      @key = key
    end

    %w(ratingKey guid studio title contentRating summary rating year tagline
       thumb art duration originallyAvailableAt addedAt updatedAt).each { |method|
      class_eval %(
        def #{Plex.snake_case(method)}
          @#{Plex.snake_case(method)} ||= video.attr('#{method}')
        end
      )
    }

    %w(Writer Director Country Role).each { |tag|
      class_eval %(
        def #{tag.downcase}s
          @#{tag.downcase}s ||= 
            xml_doc.search('#{tag}').map { |node| #{tag}.new(node.actributes) }.compact
        end
        def #{tag.downcase}; #{tag.downcase}s.first end
      )
    }

    def media
      @media ||= Plex::Parser.new(xml_doc.search('Media').first).parse
    end

    private

    def xml_doc
      @xml_doc ||= Nokogiri::XML( open(Plex.url+key) )
    end

    def video
      @video ||= xml_doc.search('Video').first
    end

  end
end
