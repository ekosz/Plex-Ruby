module Plex
  class Media

    ATTRIBUTES = %w(id durration bitrate aspectRatio audioChannels
                    audioCodec videoCodec videoResolution container videoFrameRate)

    attr_reader *ATTRIBUTES.map {|m| Plex.snake_case(m) }
    attr_reader :parts

    # @param [Nokogiri::XML::Element] nokogiri element that represents this
    #   Media
    def initialize(node)
      ATTRIBUTES.each { |e|
        instance_variable_set("@#{Plex.snake_case(e)}", node.attr(e))
      }

      @parts = node.search("Part").map { |m| Plex::Part.new(m) }
    end

    def ==(other)
      if other.is_a? Media
        id == other.id
      else
        super
      end
    end

  end
end
