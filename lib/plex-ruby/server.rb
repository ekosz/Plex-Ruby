module Plex
  class Server

    attr_reader :host, :port

    def initialize(host, port)
      @host = host
      @port = port
      Plex.url = "http://#{host}:#{port}"
    end

    def system
    end

    def libary
      @libary ||= Plex::Libary.new
    end

    def clients
      @clients ||= clients_doc.search('Server').map { |m| Plex::Client.new(m) }
    end

    private

    def clients_doc
      @clients_doc ||= Nokogiri::XML( open(Plex.url+'/clients') )
    end

  end
end
