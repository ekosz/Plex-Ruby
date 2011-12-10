module Plex
  class Part

    ATTRIBUTES = %w(id key duration file size)

    attr_reader *ATTRIBUTES.map {|m| Plex.snake_case(m) }
    attr_reader :streams

    # @param [Nokogiri::XML::Element] nokogiri element that represents this
    #   part
    def initialize(node)
      ATTRIBUTES.each { |e|
        instance_variable_set("@#{Plex.snake_case(e)}", node.attr(e))
      }

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
