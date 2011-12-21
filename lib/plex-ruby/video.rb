module Plex
  class Video

    ATTRIBUTES = %w(ratingKey key studio type title titleSort contentRating summary 
                    rating viewCount year tagline thumb art duration 
                    originallyAvailableAt updatedAt)
      
    attr_reader :media, :genres, :writers, :directors, :roles

    # @param [Nokogiri::XML::Element] nokogiri element that represents this
    #   Video
    def initialize(node)
      node.attributes.each do |method, val|
        define_singleton_method(Plex.underscore(method).to_sym) do
          val.value
        end
      end

      @media      = Plex::Media.new(node.search('Media').first)
      @genres     = node.search('Genre').map    { |m| Plex::Genre.new(m)    }
      @writers    = node.search('Writer').map   { |m| Plex::Writer.new(m)   }
      @directors  = node.search('Director').map { |m| Plex::Director.new(m) } 
      @roles      = node.search('Role').map     { |m| Plex::Role.new(m)     } 
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
