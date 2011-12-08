module Plex
  # Found at /libary/metadata/:key
  class Show

    ATTRIBUTES = %w(guid studio title contentRating summary index rating year thumb 
                    art banner theme duration originallyAvailableAt leafCount 
                    viewedLeafCount addedAt updatedAt)

    attr_reader :key

    def initialize(key)
      @key = key
    end

    # A Show has a key, which allows us to do lazy loading.  A Show will
    # not be fully loaded unless one of its attributes is called.  Then the
    # Show will load itself from its key. Once loaded it caches its self.
    ATTRIBUTES.each { |method|
      class_eval %(
        def #{Plex.snake_case(method)}; @#{method} ||= directory.attr('#{method}') end
      )
    }

    # The list of seasons in the library that belong to this Show
    #
    # @return [Array] list of Seasons that are a part of this Show
    def seasons
      @seasons ||=
        children.search('Directory').map do |season|
          Plex::Season.new(season.attr('key')[0..-10]) # Remove /children
        end
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
