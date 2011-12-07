module Plex
  # Found at /libary/metadata/:key
  class Season

    attr_reader :key

    def initialize(key)
      @key = key
    end

    %w(ratingKey guid type title summary index thumb leafCount viewedLeafCount 
       addedAt updatedAt).each { |method|
      class_eval %(
        def #{Plex.snake_case(method)}; directory.attr('#{method}') end
      )
    }

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
