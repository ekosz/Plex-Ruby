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

      directory.attributes.each do |method, val|
        define_singleton_method(Plex.underscore(method).to_sym) do
          val.value
        end
        define_singleton_method(Plex.underscore(method+'!').to_sym) do
          puts "Plex::Season##{Plex.underscore(method+'!')} IS DEPRECATED! Use Plex::Season##{Plex.underscore(method)} instead."
          self.send(Plex.underscore(method))
        end
      end
    end

    # Returns the list of episodes in the library that are a part of this Season
    #
    # @return [Array] list of episodes in this season that are on the server
    def episodes
      @episodes ||= episodes_from_video(children)
    end

    # Select a particular episode
    #
    # @param [Fixnum, String] episode index number
    # @return [Episode] episode with the index of number
    def episode(number)
      episodes.select { |epi| epi.index.to_i == number.to_i }.first
    end

    def url
      show.url
    end

    def ==(other)
      if other.is_a? Plex::Season
        key == other.key
      else
        super
      end
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

    def children 
      @children ||= base_children_doc
    end

    def episodes_from_video(node)
      node.search("Video").map { |m| Plex::Episode.new(self, m.attr('key')) }
    end

    def directory
      @directory ||= xml_doc.search("Directory").first
    end

  end
end
