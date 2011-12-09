module Plex
  class Video
    
    attr_reader :rating_key, :key, :studio, :type, :title, :title_sort, 
      :content_rating, :summary, :rating, :view_count, :year, :tagline, :thumb, :art, 
      :duration, :originally_available_at, :updated_at, :media, :genres, :writers,
      :directors, :roles

    # @param [Nokogiri::XML::Element] nokogiri element that represents this
    #   Video
    def initialize(node)
      @rating_key               = node.attr('ratingKey')
      @key                      = node.attr('key')
      @studio                   = node.attr('studio')
      @type                     = node.attr('type')
      @title                    = node.attr('title')
      @title_sort               = node.attr('titleSort')
      @content_rating           = node.attr('contentRating')
      @summary                  = node.attr('summary')
      @rating                   = node.attr('rating')
      @view_count               = node.attr('viewCount')
      @year                     = node.attr('year')
      @tagline                  = node.attr('tagline')
      @thumb                    = node.attr('thumb')
      @art                      = node.attr('art')
      @duration                 = node.attr('duration')
      @originally_available_at  = node.attr('originallyAvailableAt')
      @updated_at               = node.attr('updatedAt')

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
