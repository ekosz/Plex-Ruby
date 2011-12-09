require 'test_helper'

describe Plex::Section do
  before do
    @section = Plex::Section.new(FakeParent.new, FakeNode.new(FAKE_SECTION_NODE_HASH))
  end

  %w(refreshing type title art agent scanner language updated_at).each { |method|
    it "should respond to ##{method}" do
      @section.send(method.to_sym).must_equal FAKE_SECTION_NODE_HASH[method.to_sym]
    end
  }
end
