module Plex
  class Player

    ATTRIBUTES = %w(machineIdentifier platform product state title)

    attr_reader :parts

    # @param [Nokogiri::XML::Element] nokogiri element that represents this
    #   Media
    def initialize(node)
      node.attributes.each do |method, val|
        define_singleton_method(Plex.underscore(method).to_sym) do
          val.value
        end
      end
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
