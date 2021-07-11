module Plex
  class Track

    ATTRIBUTES = %w(ratingKey title originalTitle summary index duration thumb year addedAt updatedAt)

    attr_reader :section, :key, :attribute_hash
    attr_reader :medias

    # @param [Album] Album this Track belongs to
    # @param [String] key to use to later grab this Track
    # @param [Nokogiri::XML::Element] Media node(s)
    def initialize(section, key, medias = nil)
      @section = section
      @key = key
      @attribute_hash = {}

      track.attributes.each do |method, val|
        @attribute_hash[Plex.underscore(method)] = val.value
        define_singleton_method(Plex.underscore(method).to_sym) do
          val.value
        end
      end

      @attribute_hash.merge({'key' => @key})

      @medias = medias.map { |m| Plex::Media.new(m) }
    end

    # @private
    def url #:nodoc:
      section.url
    end

    # @private
    def ==(other) #:nodoc:
      if other.is_a? Plex::Track
        key == other.key
      else
        super
      end
    end

    # @private
    def inspect #:nodoc:
      "#<Plex::Track: key=\"#{key}\" title=\"#{title}\" track=\"#{index}\">"
    end

    private

    def base_doc
      Nokogiri::XML( open(url+key) )
    end

    def children_base
      Nokogiri::XML( open(url+key+'/children') )
    end

    def xml_doc
      @xml_doc ||= base_doc
    end

    def children
      @children ||= children_base
    end

    def track
      @track ||= xml_doc.search('Track').first
    end

  end

end
