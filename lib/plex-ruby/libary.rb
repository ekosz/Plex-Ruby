module Plex
  class Libary

    def section(id)
      xml_doc.search("Directory[@key='#{id}']").map do |m| 
        Plex::Section.new(m.attributes) 
      end.first
    end

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
