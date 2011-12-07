module Plex
  class Section

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

    def refresh(deep = false, force = false)
    end


    %w(all unwatched newest recentlyAdded recentlyViewed onDeck).each { |method|
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
