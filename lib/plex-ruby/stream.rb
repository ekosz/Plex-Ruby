module Plex
  class Stream

    attr_reader :part, :id, :stream_type, :codec, :index, :language, :language_code

    def initialize(part, id, st, co, ix, la, lc)
      @part           = part
      @id             = id
      @stream_type    = st
      @codec          = co
      @index          = ix
      @language       = la
      @language_code  = lc
    end

    def self.build_from_xml(part, xml)
      new()
    end

  end
end
