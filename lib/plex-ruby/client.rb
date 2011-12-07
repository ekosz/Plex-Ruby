module Plex
  class Client

    attr_reader :name, :host, :address, :port, :machine_identifier, :version

    def initialize(node)
      @name = node.attr('name')
      @host = node.attr('host')
      @address = node.attr('address')
      @port = node.attr('port')
      @machine_identifier = node.attr('machineIdentifier')
      @version = node.attr('version')
    end

    %w(moveUp moveDown moveLeft moveRight pageUp pageDown nextLetter previousLetter 
       select back contextMenu toggleOSD).each { |nav|
      class_eval %(
        def #{Plex.snake_case(nav)}
          ping player_url+'/navigation/#{nav}'
        end
      )
    }

    %w(play pause stop rewind fastForward stepForward bigStepForward stepBack 
       bigStepBack skipNext skipPrevious).each { |playback|
      class_eval %(
        def #{Plex.snake_case(playback)}
          ping player_url+'/playback/#{playback}'
        end
      )
    }

    def play_file
      ping player_url+"/application/playFile"
    end

    def play_media(key, user_agent = nil, http_cookies = nil, view_offset = nil)
      url = player_url+'/application/playMedia?'
      url += "path=#{CGI::escape(Plex.url+key)}"
      url += "&key=#{CGI::escape(key)}"
      url += "&userAgent=#{user_agent}" if user_agent
      url += "&httpCookies=#{http_cookies}" if http_cookies
      url += "&viewOffset=#{view_offset}" if view_offset

      ping url
    end

    def screenshot(width, height, quality)
      url = player_url+'/application/screenshot?'
      url += "width=#{width}"
      url += "&height=#{height}"
    end

    def send_string(text)
      ping player_url+"/application/sendString?text=#{CGI::escape(text)}"
    end

    def send_key(code)
      ping player_url+"/application/sendKey?code=#{CGI::escape(code)}"
    end

    def send_virtual_key(code)
      ping player_url+"/application/sendVirtualKey?code=#{CGI::escape(code)}"
    end

    private

    def player_url
      Plex.url+"/system/players/#{name}"
    end

    def ping(url)
      !!open(url).read
    rescue => e
      puts "Error trying to ping #{url} - #{e.message}"
    end

  end
end
