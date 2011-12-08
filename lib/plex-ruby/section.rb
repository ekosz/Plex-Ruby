module Plex
  class Section

    GROUPS = %w(all unwatched newest recentlyAdded recentlyViewed onDeck)

    attr_reader :refreshing, :type, :title, :art, :agent, :scanner, :language, 
      :updated_at

    def initialize(options)
      @refreshing = options['refreshing'].value
      @key        = options['key'].value
      @type       = options['type'].value
      @title      = options['title'].value
      @art        = options['art'].value
      @agent      = options['agent'].value
      @scanner    = options['scanner'].value
      @language   = options['language'].value
      @updated_at = options['updatedAt'].value
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
        def #{Plex.snake_case(method)}
          Plex::Parser.new( Nokogiri::XML(open(Plex.url+key+'/#{method}')) ).parse
        end
      )
    }

    def key
      "/library/sections/#{@key}"
    end

  end
end
