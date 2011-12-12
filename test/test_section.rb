require 'test_helper'

describe Plex::Section do
  before do
    @library = FakeParent.new
    @section = Plex::Section.new(@library, FakeNode.new(FAKE_SECTION_NODE_HASH))
  end

  (Plex::Section::ATTRIBUTES - %w(key)).map{|m| Plex.snake_case(m)}.each { |method|
    it "should respond to ##{method}" do
      @section.send(method.to_sym).must_equal FAKE_SECTION_NODE_HASH[method.to_sym]
    end
  }

  it "should remember its parent (library)" do
    @section.library.must_equal @library
  end

end
