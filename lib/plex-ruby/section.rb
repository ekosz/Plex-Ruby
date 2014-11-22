module Plex
  class Section

    GROUPS = %w(all unwatched newest recentlyAdded recentlyViewed onDeck)

    ATTRIBUTES = %w(refreshing key type title art agent scanner language updatedAt)

    CATEGORIES = %w(collection firstCharacter genre year contentRating folder)

    attr_reader *ATTRIBUTES.map {|m| Plex.underscore(m) }
    attr_reader :library

    # @param [Library] library this Section belongs to
    # @param [Nokogiri::XML::Element] nokogiri element that represents this
    #   Section
    def initialize(library, node)
      @library = library
      ATTRIBUTES.each { |e|
        instance_variable_set("@#{Plex.underscore(e)}", node.attr(e))
      }
    end

    # NOT IMPLEMENTED
    def refresh(deep = false, force = false)
    end


    # Returns a list of shows or movies that are in this Section.
    #
    # all - all videos in this Section
    # unwatched - videos unwatched in this Section
    # newest - most recent videos in this Section
    # recently_added - recently added videos in this Section
    # recently_viewed - recently viewed videos in this Section
    # on_deck - videos that are "on deck" in this Section
    #
    # @return [Array] list of Shows or Movies in that group
    GROUPS.each { |method|
      class_eval %(
        def #{Plex.underscore(method)} do |options = {}|
          path = '/' + method + '?'
          path += "title=#{CGI::escape(options[:title])}" if options[:title]
          path += "type=4" if options[:episodes]
          Plex::Parser.new( self, Nokogiri::XML(Plex.open(url+key+path)) ).parse
        end
      )
    }

    # Find TV Shows / Episodes by categories
    #
    # Format:
    #    #{category}s        - Grab the keys => title in that category
    #    #{category}s!       - cache busing version of #{category}s
    #    by_#{category}(key) - all shows / movies by that key
    #
    # Example:
    #
    #     library.section(2).by_year(2008) # List of TV Shows from 2008
    #     library.section(1).by_first_character("H") # movies starting with 'H'
    #     library.section(2).genres # Array of Hashes explaining all of the genres
    #
    # collection      - I'm not sure
    # first_character - the first letter of the title of the video
    # genre           - self explanatory
    # year            - year first shown
    # content_rating  - TV-14, TV-MA, etc
    # folder          - where the video is stored
    CATEGORIES.each { |method|
      class_eval %(
        def #{Plex.underscore(method)}s
          @#{Plex.underscore(method)}s ||= grab_keys('#{method}')
        end
        def #{Plex.underscore(method)}s!
          @#{Plex.underscore(method)}s = grab_keys('#{method}')
        end
        def by_#{Plex.underscore(method)}(val)
          Plex::Parser.new( self, Nokogiri::XML(Plex.open(url+key+"/#{method}/\#{val}")) ).parse
        end
      )
    }

    # @private
    def key #:nodoc:
      "/library/sections/#{@key}"
    end

    # @private
    def url #:nodoc:
      library.url
    end

    # @private
    def ==(other) #:nodoc:
      if other.is_a? Plex::Section
        key == other.key
      else
        super
      end
    end

    # @private
    def inspect #:nodoc:
      "#<Plex::Section: key=\"#{key}\" type=\"#{type}\" title=\"#{title}\">"
    end

    private

    def grab_keys(action)
      Nokogiri::XML(Plex.open(url+key+"/#{action}")).search('Directory').map do |node|
        {
          key: node.attr('key'),
          title: node.attr('title')
        }
      end
    end


  end
end
