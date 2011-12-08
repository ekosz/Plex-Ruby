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

      @streams  = node.search('Stream').map { |m| Stream.new(m) }
    end

  end
end
