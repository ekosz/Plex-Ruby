module Plex
  class Libary

    # Grab a specific section
    #
    # @param [String, Fixnum] key of the section we want
    # @return [Section] section with that key
    def section(id)
      xml_doc.search("Directory[@key='#{id}']").map do |m| 
        Plex::Section.new(m.attributes) 
      end.first
    end

    # A list of sections that are located in this libary
    #
    # @return [Array] list of sections
    def sections
      xml_doc.search('Directory').map { |m| Plex::Section.new(m.attributes) }
    end

    def key
      "/library/sections"
    end

    private

    def xml_doc
      @xml_doc ||= Nokogiri::XML( open(Plex.url+key) )
    end

  end
end
