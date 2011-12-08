module Plex
  # Found at /library/metadata/:key
  class Season

    ATTRIBUTES = %w(ratingKey guid type title summary index thumb leafCount 
                    viewedLeafCount addedAt updatedAt) 

    attr_reader :show, :key

    # @param [Show] show this Season belongs to
    # @param [String] key to later grab this Season from
    def initialize(show, key)
      @show = show
      @key = key
    end

    # A Season has a key, which allows us to do lazy loading.  A season will
    # not be fully loaded unless one of its attributes is called.  Then the
    # Season will load itself from its key. Once loaded it caches its self.
    # For every attribute there is a cache busting version wich is just the
    # name of the attribute followed by '!'. For exsample <tt>season.type</tt>
    # and <tt>season.type!</tt>
    ATTRIBUTES.each { |method|
      class_eval %(
        def #{Plex.snake_case(method)}; directory.attr('#{method}') end
        def #{Plex.snake_case(method)}!; directory!.attr('#{method}') end
      )
    }

    # Returns the list of episodes in the library that are a part of this Season
    #
    # @return [Array] list of episodes in this season that are on the server
    def episodes
      @episodes ||= episodes_from_video(children)
    end

    # Cache busting version of #episodes
    def episodes!
      @episodes = episodes_from_video(children!)
    end

    def url
      show.url
    end

    private

    def base_doc
      Nokogiri::XML( open(url+key) )
    end

    def base_children_doc
      Nokogiri::XML( open(url+key+'/children') )
    end

    def xml_doc
      @xml_doc ||= base_doc
    end

    def xml_doc!
      @xml_doc = base_doc
    end

    def children 
      @children ||= base_children_doc
    end

    def children!
      @children = base_children_doc 
    end

    def episodes_from_video(node)
      node.search("Video").map { |m| Plex::Episode.new(self, m.attr('key')) }
    end

    def directory
      @directory ||= xml_doc.search("Directory").first
    end

    def directory!
      @directory = xml_doc!.search("Directory").first
    end

  end
end
