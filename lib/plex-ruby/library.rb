module Plex
  class Library

    attr_reader :server

    WATCHED_LINK = "/:/scrobble?identifier=com.plexapp.plugins.library&key="
    UNWATCHED_LINK = "/:/unscrobble?identifier=com.plexapp.plugins.library&key="

    # @param [Server] server this libary belongs to
    def initialize(server)
      @server = server
    end

    # Grab a specific section
    #
    # @param [String, Fixnum] key of the section we want
    # @return [Section] section with that key
    def section(id)
      search_sections(xml_doc, id).first
    end

    # Cache busting version of #section
    def section!(id)
      search_sections(xml_doc!, id).first
    end

    # A list of sections that are located in this library
    #
    # @return [Array] list of sections
    def sections
      @sections ||= search_sections(xml_doc)
    end

    # Cache busting version of #sections
    def sections!
      @sections = search_sections(xml_doc!)
    end

    # Set the video as watched
    #
    # @param [Video] video to be set as watched
    def watched(video)
      open(url+WATCHED_LINK+video.rating_key)
    end

    # Set the video as unwatched
    #
    # @param [Video] video to be set as unwatched
    def unwatched(video)
      open(url+UNWATCHED_LINK+video.rating_key)
    end

    # @private
    def key #:nodoc:
      "/library/sections"
    end

    # @private
    def url #:nodoc:
      server.url
    end

    # @private
    def ==(other) #:nodoc:
      if other.is_a? Library
        server == other.server
      else
        super
      end
    end

    # @private
    def inspect #:nodoc:
      "#<Plex::Libary: server=#{server.inspect}>"
    end

    private

    def search_sections(doc, key = nil)
      term = key ? "Directory[@key='#{key}']" : 'Directory'
      doc.search(term).map { |m| Plex::Section.new(self, m) }
    end

    def xml_doc
      @xml_doc ||= base_doc
    end

    def xml_doc!
      @xml_doc = base_doc
    end

    def base_doc
      Nokogiri::XML( open(url+key) )
    end


  end
end
