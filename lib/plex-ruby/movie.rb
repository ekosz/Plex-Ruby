module Plex
  class Movie
    attr_reader :section, :key

    # @param [Section] section this movie belongs in
    # @param [String] key to later referance this Movie
    def initialize(section, key)
      @section = section
      @key = key
    end

    # Returns the attribute hash that represents this Movie
    def attribute_hash
      video.attribute_hash.merge({'key' => key})
    end

    # Delegates all method calls to the video object that represents this
    # movie, if that video object responds to the method.
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
      section.url
    end

    # @private
    def inspect #:nodoc:
      "#<Plex::Movie: key=\"#{key}\" title=\"#{title}\">"
    end

    private

    def xml_doc
      @xml_doc ||= Nokogiri::XML(Plex.open(url+key))
    end

    def video
      @video ||= Plex::Video.new(xml_doc.search('Video').first)
    end
  end
end
