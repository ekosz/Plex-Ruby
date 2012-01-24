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
      seasons.detect { |sea| sea.index.to_i == number.to_i }
    end

    # Helper method for selecting the special Season of this show
    # Season 0 is where Plex stores episodes that are not part of a 
    # regular season. i.e. Christmas Specials
    #
    # @return [Season] season with index of 0
    def special_season
      season(0)
    end

    # Selects the first season of this show that is on the Plex Server
    # Does not select season 0
    #
    # @return [Season] season with the lowest index (but not 0)
    def first_season
      seasons.inject { |a, b| a.index.to_i < b.index.to_i && a.index.to_i > 0 ? a : b }
    end

    # Selects the last season of this show that is on the Plex Server
    #
    # @return [Season] season with the highest index
    def last_season
      seasons.max_by { |s| s.index.to_i }
    end

    # Selects the first episode of this show that is on the Plex Server
    #
    # @return [Episode] episode with the lowest index of the season of the
    #   lowest index
    def first_episode
      first_season.first_episode
    end

    # Selects the last episode of this show that is on the Plex Server
    #
    # @return [Episode] episode with the highest index of the season of the
    #   highest index
    def last_episode
      last_season.last_episode
    end

    # @private
    def url #:nodoc:
      section.url
    end

    # @private
    def ==(other) #:nodoc:
      if other.is_a? Plex::Show
        key == other.key
      else
        super
      end
    end

    # @private
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
