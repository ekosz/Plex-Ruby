require 'test_helper'

describe Plex::Library do
  before do
    @library = Plex::Library.new(FakeParent.new)
    @library.instance_variable_set("@xml_doc", FakeNode.new(FAKE_LIBRARY_NODE_HASH))
  end


  it "should return a list of sections" do
    @library.sections.must_equal(
      Array( Plex::Section.new(nil, FakeNode.new(FAKE_SECTION_NODE_HASH)) )
    )
  end

  it "should return the proper section when specisfied" do
    @library.section(FAKE_SECTION_NODE_HASH[:key]).must_equal(
      Plex::Section.new(nil, FakeNode.new(FAKE_SECTION_NODE_HASH))
    )
  end
end
