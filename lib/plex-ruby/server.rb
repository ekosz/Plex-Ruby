module Plex
  class Server

    attr_reader :host, :port

    def initialize(host, port)
      @host = host
      @port = port
      Plex.url = "http://#{host}:#{port}"
    end

    # The library of this server
    #
    # @return [Library] this Servers library
    def libary
      @libary ||= Plex::Libary.new
    end

    # The Plex clients that are connected to this Server
    # 
    # @return [Array] list of Clients connected to this server
    def clients
      @clients ||= clients_doc.search('Server').map { |m| Plex::Client.new(m) }
    end

    private

    def clients_doc
      @clients_doc ||= Nokogiri::XML( open(Plex.url+'/clients') )
    end

  end
end
