module Plex
  class Video
    ATTRIBUTES = %w(ratingKey key studio type title titleSort contentRating summary
                    rating viewCount year tagline thumb art duration
                    originallyAvailableAt updatedAt)

    attr_reader :medias, :genres, :writers, :directors, :roles, :collections, :attribute_hash

    # @param [Nokogiri::XML::Element] nokogiri element that represents this
    #   Video
    def initialize(node)
      @attribute_hash = {}
      node.attributes.each do |method, val|
        @attribute_hash[Plex.underscore(method)] = val.value
        define_singleton_method(Plex.underscore(method).to_sym) do
          val.value
        end
      end

      @medias      = node.search('Media').map      { |m| Plex::Media.new(m)      }
      @genres      = node.search('Genre').map      { |m| Plex::Genre.new(m)      }
      @writers     = node.search('Writer').map     { |m| Plex::Writer.new(m)     }
      @directors   = node.search('Director').map   { |m| Plex::Director.new(m)   }
      @roles       = node.search('Role').map       { |m| Plex::Role.new(m)       }
      @collections = node.search('Collection').map { |m| Plex::Collection.new(m) }
    end


    def ==(other)
      if other.is_a? Video
        key == other.key
      else
        super
      end
    end

  end
end
