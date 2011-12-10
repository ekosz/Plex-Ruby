module Plex
  class Stream

    ATTRIBUTES = %w(id streamType codec index language languageCode)

    attr_reader *ATTRIBUTES.map {|m| Plex.snake_case(m) }

    # @param [Nokogiri::XML::Element] nokogiri element that represents this
    #   Stream
    def initialize(node)
      ATTRIBUTES.each { |e|
        instance_variable_set("@#{Plex.snake_case(e)}", node.attr(e))
      }
    end

    def ==(other)
      if other.is_a? Plex::Stream
        id == other.id
      else
        super
      end
    end

  end
end
