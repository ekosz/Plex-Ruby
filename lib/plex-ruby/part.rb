module Plex
  class Part

    attr_reader :id, :key, :duration, :file, :size, :streams

    # @param [Nokogiri::XML::Element] nokogiri element that represents this
    #   part
    def initialize(node)
      @id       = node.attr('id')
      @key      = node.attr('key')
      @duration = node.attr('duration')
      @file     = node.attr('file')
      @size     = node.attr('size')

      @streams  = node.search('Stream').map { |m| Plex::Stream.new(m) }
    end

    def ==(other)
      if other.is_a? Plex::Part
        id == other.id
      else
        super
      end
    end

  end
end
