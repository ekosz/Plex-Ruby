module Plex
  class System

    attr_reader :server

    def initialize(server)
      @server = server
    end

    def host
      server.host
    end

    def port
      server.port
    end

    def players
    end

  end
end
