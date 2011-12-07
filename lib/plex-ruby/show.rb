module Plex
  # Found at /libary/metadata/:key
  class Show

    attr_reader :key

    def initialize(key)
      @key = key
    end

    %w(guid studio title contentRating summary index rating year thumb art banner
       theme duration originallyAvailableAt leafCount viewedLeafCount addedAt
       updatedAt).each { |method|
      class_eval %(
        def #{Plex.snake_case(method)}; @#{method} ||= directory.attr('#{method}') end
      )
    }

    def seasons
      @seasons ||=
        children.search('Directory').map do |season|
          Plex::Season.new(season.attr('key')[0..-10]) # Remove /children
        end.compact
    end

    private

    def children
      @children ||= Nokogiri::XML( open(Plex.url+key+'/children') )
    end

    def directory
      @directory ||= xml_doc.search('Directory').first
    end
    
    def xml_doc
      @xml_doc ||= Nokogiri::XML( open(Plex.url+key) )
    end

  end

end
