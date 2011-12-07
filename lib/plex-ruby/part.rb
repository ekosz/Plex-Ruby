module Plex
  class Part

    attr_reader :media, :id, :key, :duration, :file, :size, :streams

    def initialize(media, id, key, duration, file, size, streams)
      @media    = media
      @id       = id
      @key      = key
      @duration = duration
      @file     = file
      @size     = size
      @streams  = streams
    end

    def self.build_from_xml(media, xml)
      new()
    end

  end
end
