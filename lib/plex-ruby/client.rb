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

    # Navigation methods
    # Sends a movement command to the client to move around menus and such
    #
    # @return [True, nil] true if it worked, nil if something went wrong check
    #   the console for the error message
    %w(moveUp moveDown moveLeft moveRight pageUp pageDown nextLetter previousLetter 
       select back contextMenu toggleOSD).each { |nav|
      class_eval %(
        def #{Plex.snake_case(nav)}
          ping player_url+'/navigation/#{nav}'
        end
      )
    }

    # Playback methods
    # Sends a playback command to the client to play / pause videos and such
    #
    # @return [True, nil] true if it worked, nil if something went wrong check
    #   the console for the error message
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

    # Plays a video that is in the library
    #
    # @param [String] the key of the video that we want to play.  (see
    #   Episode#key) (see Movie#key)
    # @param [String] no clue what this does, its the Plex Remote Command API though
    # @param [String] no clue what this does, its the Plex Remote Command API though
    # @param [String] no clue what this does, its the Plex Remote Command API though
    # @return [True, nil] true if it worked, nil if something went wrong check
    #   the console for the error message
    def play_media(key, user_agent = nil, http_cookies = nil, view_offset = nil)
      url = player_url+'/application/playMedia?'
      url += "path=#{CGI::escape(Plex.url+key)}"
      url += "&key=#{CGI::escape(key)}"
      url += "&userAgent=#{user_agent}" if user_agent
      url += "&httpCookies=#{http_cookies}" if http_cookies
      url += "&viewOffset=#{view_offset}" if view_offset

      ping url
    end

    # Take a screenshot of whats on the Plex Client
    #
    # @param [String, Fixnum] width of the screenshot
    # @param [String, Fixnum] height of the screenshot
    # @param [String, Fixnum] quality of the screenshot
    # @return [True, nil] true if it worked, nil if something went wrong check
    #   the console for the error message
    def screenshot(width, height, quality)
      url = player_url+'/application/screenshot?'
      url += "width=#{width}"
      url += "&height=#{height}"
      url += "&quality=#{quality}"

      ping url
    end

    # Sends a string message to the Plex Client
    #
    # @param [String] message to send
    # @return [True, nil] true if it worked, nil if something went wrong check
    #   the console for the error message
    def send_string(text)
      ping player_url+"/application/sendString?text=#{CGI::escape(text.to_s)}"
    end

    # Sends a key code to the Plex Client.  Key codes represent key presses on
    # a keyboard. Codes are the ASCII value of the letter one wants pressed.
    # It should be noted that the Plex devs have told people to try and avoid
    # using this method when writing plugins, as different users can have
    # different key mappings.
    #
    # @param [String, Fixnum] key code to send
    # @return [True, nil] true if it worked, nil if something went wrong check
    #   the console for the error message
    def send_key(code)
      ping player_url+"/application/sendKey?code=#{CGI::escape(code.to_s)}"
    end

    # (see #send_key)
    def send_virtual_key(code)
      ping player_url+"/application/sendVirtualKey?code=#{CGI::escape(code.to_s)}"
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
