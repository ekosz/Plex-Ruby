module Plex
  class Album

    ATTRIBUTES = %w(ratingKey guid title summary index thumb year addedAt updatedAt)

    attr_reader :section, :key, :attribute_hash

    # @param [Artist] Artist this album belongs to
    # @param [String] key to use to later grab this Album
    def initialize(section, key)
      @section = section
      @key = key
      @attribute_hash = {}

      directory.attributes.each do |method, val|
        @attribute_hash[Plex.underscore(method)] = val.value
        define_singleton_method(Plex.underscore(method).to_sym) do
          val.value
        end
      end

      @attribute_hash.merge({'key' => @key})
    end

    # The list of Tracks in the library that belong to this Album
    #
    # @return [Array] list of Tracks that appear on this Album
    def tracks
      search_children children
    end

    # @private
    def url #:nodoc:
      section.url
    end

    # @private
    def ==(other) #:nodoc:
      if other.is_a? Plex::Album
        key == other.key
      else
        super
      end
    end

    # @private
    def inspect #:nodoc:
      "#<Plex::Album: key=\"#{key}\" title=\"#{title}\">"
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

    def directory
      @directory ||= xml_doc.search('Directory').first
    end

    def search_children(node)
      node.search('Track').map do |track|
        plex_track.new(self, track.attr('key'), track.search('Media'))
      end
    end

    def plex_track
      @plex_track ||= Plex::Track
    end

  end

end
