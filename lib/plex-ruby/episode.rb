module Plex
  class Episode

    attr_reader :key

    def initialize(key)
      @key = key
    end
    
    def method_missing(method, *args, &block)
      if video.respond_to? method
        video.send(method, *args, &block)
      else
        super
      end
    end

    private

    def xml_doc
      @xml_doc ||= Nokogiri::XML( open(Plex.url+key) )
    end

    def video
      @video ||= Plex::Video.new(xml_doc.search('Video').first)
    end

  end
end
