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

  end
end
