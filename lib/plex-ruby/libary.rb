module Plex
  class Libary

    # Grab a specific section
    #
    # @param [String, Fixnum] key of the section we want
    # @return [Section] section with that key
    def section(id)
      search_sections(xml_doc, id).first
    end

    # Cache busting version of #section
    def section!(id)
      search_sections(xml_doc!, id).first
    end

    # A list of sections that are located in this libary
    #
    # @return [Array] list of sections
    def sections
      @sections ||= search_sections(xml_doc)
    end

    # Cache busting version of #sections
    def sections!
      @sections = search_sections(xml_doc!)
    end

    def key
      "/library/sections"
    end

    private

    def search_sections(doc, key = nil)
      term = key ? "Directory[@key='#{key}']" : 'Directory'
      doc.search(term).map { |m| Plex::Section.new(m.attributes) }
    end

    def xml_doc
      @xml_doc ||= base_doc
    end

    def xml_doc!
      @xml_doc = base_doc
    end

    def base_doc
      Nokogiri::XML( open(Plex.url+key) )
    end


  end
end
