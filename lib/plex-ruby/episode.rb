module Plex
  class Episode

    attr_reader :season, :key

    # @param [Season] season this episode belongs to
    # @param [String] key that we can use to later grab this Episode
    def initialize(season, key)
      @season = season
      @key = key
    end

    # Returns the attribute hash that represents this Episode
    def attribute_hash
      video.attribute_hash.merge({'key' => key})
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

    def respond_to?(method)
      super || video.respond_to?(method)
    end

    def methods
      (super + video.methods).uniq
    end

    # @private
    def url #:nodoc:
      season.url
    end

    # @private
    def ==(other) #:nodoc:
      if other.is_a? Plex::Episode
        key == other.key
      else
        super
      end
    end

    # @private
    def inspect #:nodoc:
      "#<Plex::Episode key=\"#{key}\" title=\"#{title}\" index=\"#{index}\" season=\"#{season.index}\" show=\"#{season.show.title}\">"
    end

    private

    def xml_doc
      @xml_doc ||= Nokogiri::XML( Plex.open(url+key) )
    end

    def video
      @video ||= Plex::Video.new(xml_doc.search('Video').first)
    end

  end
end
