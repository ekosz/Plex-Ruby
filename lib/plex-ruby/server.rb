module Plex
  class Server

    attr_reader :host, :port

    def initialize(host, port)
      @host = host
      @port = port
    end

    # The library of this server
    #
    # @return [Library] this Servers library
    def library
      @library ||= Plex::Library.new(self)
    end
    
    # The current status of this server
    #
    # @return [Status] this Servers status
    def status
      @status ||= Plex::Status.new(self)
    end

    # The Plex clients that are connected to this Server
    #
    # @return [Array] list of Clients connected to this server
    def clients
      @clients ||= search_clients clients_doc
    end

    # Cache busting version of #clients
    def clients!
      @clients = search_clients clients_doc!
    end

    # @private
    def url #:nodoc:
      "http://#{host}:#{port}"
    end

    # @private
    def inspect #:nodoc:
      "#<Plex::Server: host=#{host} port=#{port}>"
    end

    private

    def clients_base
      Nokogiri::XML( Plex.open(url+'/clients') )
    end

    def clients_doc
      @clients_doc ||= clients_base
    end

    def clients_doc!
      @clients_doc = clients_base
    end

    def search_clients(node)
      node.search('Server').map { |m| Plex::Client.new(self, m) }
    end

  end
end
