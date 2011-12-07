module Plex
  class Player

    attr_reader :system, :name

    def initialize(system, name)
      @system = system
      @name = name
    end

    def self.build_from_xml(system, xml)
    end

    def host
      system.host
    end

    def port
      system.port
    end

    def move_up
    end

    def move_down
    end

    def move_left
    end

    def move_right
    end

    def page_down
    end

    def page_up
    end

    def next_letter
    end

    def previousLetter
    end

    def select
    end

    def back
    end

    def context_menu
    end

    def toggle_osd
    end

    def play
    end

    def pause
    end

    def stop
    end

    def rewind
    end

    def fast_forward
    end

    def step_forward
    end

    def big_step_forward
    end

    def step_back
    end

    def big_step_back
    end

    def skip_next
    end

    def skip_previous
    end

    def play_file
    end

    def play_media(path, key, userAgent = Null, httpCookies = Null, viewOffset = Null)
    end

    def screenshot(width, height, quality)
    end

    def send_string(text)
    end

    def send_key(code)
    end

    def send_virtual_key(code)
    end

  end
end
