module Plex
  class Show

    ATTRIBUTES = %w(ratingKey guid studio type title contentRating summary index 
                    rating year thumb art leafCount viewedLeafCount addedAt 
                    updatedAt)

    attr_reader :section, :key

    # @param [Section] section this show belongs to
    # @param [String] key to use to later grab this Show
    def initialize(section, key)
      @section = section
      @key = key

      directory.attributes.each do |method, val|
        define_singleton_method(Plex.underscore(method).to_sym) do
          val.value
        end
        define_singleton_method(Plex.underscore(method+'!').to_sym) do
          puts "Plex::Show##{Plex.underscore(method+'!')} IS DEPRECATED! Use Plex::Show##{Plex.underscore(method)} instead."
          self.send(Plex.underscore(method))
        end
      end
    end

    # The list of seasons in the library that belong to this Show
    #
    # @return [Array] list of Seasons that are a part of this Show
    def seasons
      @seasons ||= search_children children
    end

    # Select a particular season
    #
    # @param [Fixnum, String] season index number
    # @return [Season] season with the index of number
    def season(number)
      seasons.select { |sea| sea.index.to_i == number.to_i }.first
    end

    def url #:nodoc:
      section.url
    end

    def ==(other) #:nodoc:
      if other.is_a? Plex::Show
        key == other.key
      else
        super
      end
    end

    def inspect #:nodoc:
      "#<Plex::Show: key=\"#{key}\" title=\"#{title}\">"
    end

    private

    def base_doc
      Nokogiri::XML( open(url+key) )
    end

    def children_base
      Nokogiri::XML( open(url+key+'/children') )
    end

    def xml_doc
      @xml_doc ||= base_doc
    end
    
    def children
      @children ||= children_base
    end

    def directory
      @directory ||= xml_doc.search('Directory').first
    end

    def search_children(node)
      node.search('Directory').map do |season|
        plex_season.new(self, season.attr('key')[0..-10]) # Remove /children
      end
    end

    def plex_season
      @plex_season ||= Plex::Season
    end

  end

end
