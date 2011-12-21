module Plex
  class Part

    ATTRIBUTES = %w(id key duration file size)

    attr_reader :streams

    # @param [Nokogiri::XML::Element] nokogiri element that represents this
    #   part
    def initialize(node)
      node.attributes.each do |method, val|
        define_singleton_method(Plex.underscore(method).to_sym) do
          val.value
        end
      end

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
