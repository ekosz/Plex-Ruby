module Plex
  class Artist

    ATTRIBUTES = %w(ratingKey guid title summary index thumb addedAt updatedAt)

    attr_reader :section, :key, :attribute_hash

    # @param [Section] section this artist belongs to
    # @param [String] key to use to later grab this Artist
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

    # The list of Albums in the library that belong to this Artist
    #
    # @return [Array] list of Albums that are credited to this Artist
    def albums
      @albums ||= search_children children
    end

    # @private
    def url #:nodoc:
      section.url
    end

    # @private
    def ==(other) #:nodoc:
      if other.is_a? Plex::Artist
        key == other.key
      else
        super
      end
    end

    # @private
    def inspect #:nodoc:
      "#<Plex::Artist: key=\"#{key}\" title=\"#{title}\">"
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
      node.search('Directory[type="album"]').map do |album|
        plex_album.new(self, album.attr('key')[0..-10]) # Remove /children
      end
    end

    def plex_album
      @plex_album ||= Plex::Album
    end

  end

end
