module Plex
  class Stream

    attr_reader :id, :stream_type, :codec, :index, :language, :language_code

    # @param [Nokogiri::XML::Element] nokogiri element that represents this
    #   Stream
    def initialize(node)
      @id             = node.attr('id')
      @stream_type    = node.attr('stream_type')
      @codec          = node.attr('codec')
      @index          = node.attr('index')
      @language       = node.attr('language')
      @language_code  = node.attr('language_code')
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
