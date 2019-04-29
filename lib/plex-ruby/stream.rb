module Plex
  class Stream
    ATTRIBUTES = %w(id streamType codec index language languageCode)

    # @param [Nokogiri::XML::Element] nokogiri element that represents this
    #   Stream
    def initialize(node)
      node.attributes.each do |method, val|
        define_singleton_method(Plex.underscore(method).to_sym) do
          val.value
        end
      end
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
