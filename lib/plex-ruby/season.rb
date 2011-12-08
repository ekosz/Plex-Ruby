module Plex
  # Found at /libary/metadata/:key
  class Season

    ATTRIBUTES = %w(ratingKey guid type title summary index thumb leafCount 
                    viewedLeafCount addedAt updatedAt) 

    attr_reader :key

    def initialize(key)
      @key = key
    end

    # A Season has a key, which allows us to do lazy loading.  A season will
    # not be fully loaded unless one of its attributes is called.  Then the
    # Season will load itself from its key. Once loaded it caches its self.
    ATTRIBUTES.each { |method|
      class_eval %(
        def #{Plex.snake_case(method)}; directory.attr('#{method}') end
      )
    }

    # Returns the list of episodes in the library that are a part of this Season
    #
    # @return [Array] list of episodes in this season that are on the server
    def episodes
      @episodes ||=
        children.search("Video").map { |m| Plex::Episode.new(m.attr('key')) }
    end

    private

    def xml_doc
      @xml_doc ||= Nokogiri::XML( open(Plex.url+key) )
    end

    def children 
      @children ||= Nokogiri::XML( open(Plex.url+key+'/children') )
    end

    def directory
      @directory ||= xml_doc.search("Directory").first
    end

  end
end
