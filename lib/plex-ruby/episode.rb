module Plex
  class Episode

    attr_reader :season, :key

    # @param [Season] season this episode belongs to
    # @param [String] key that we can use to later grab this Episode
    def initialize(season, key)
      @season = season
      @key = key
    end
    
    # Delegates all method calls to the video object that represents this
    # episode, if that video object responds to the method.
    def method_missing(method, *args, &block)
      if video.respond_to? method
        video.send(method, *args, &block)
      else
        super
      end
    end

    def url
      season.url
    end

    private

    def xml_doc
      @xml_doc ||= Nokogiri::XML( open(url+key) )
    end

    def video
      @video ||= Plex::Video.new(xml_doc.search('Video').first)
    end

  end
end
