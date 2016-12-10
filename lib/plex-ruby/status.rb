module Plex
  class Status

    attr_reader :server

    # @param [Server] server this libary belongs to
    def initialize(server)
      @server = server
    end

    # Grab a specific session
    #
    # @param [String, Fixnum] key of the session we want
    # @return [Video] session with that key
    def session(id)
      search_sessions(xml_doc, id).first
    end

    # Cache busting version of #session
    def session!(id)
      search_sessions(xml_doc!, id).first
    end

    # A list of sessions that are located in this library
    #
    # @return [Array] list of videos
    def sessions
      @sessions ||= search_sessions(xml_doc)
    end

    # Cache busting version of #sessions
    def sessions!
      @sessions = search_sessions(xml_doc!)
    end

    # @private
    def key #:nodoc:
      "/status/sessions"
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
      "#<Plex::Status: server=#{server.inspect}>"
    end

    private

    def search_sessions(doc, key = nil)
      term = key ? "Video[@sessionKey='#{key}']" : 'Video'
      doc.search(term).map { |m| Plex::Video.new(m) }
    end

    def xml_doc
      @xml_doc ||= base_doc
    end

    def xml_doc!
      @xml_doc = base_doc
    end

    def base_doc
      Nokogiri::XML( Plex.open(url+key) )
    end


  end
end
