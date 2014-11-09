module Plex
  class Config
    attr_accessor :auth_token

    def initialize
      @auth_token = nil
    end
  end
end
