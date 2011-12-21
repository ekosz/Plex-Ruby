require 'test_helper'

describe Plex::Media do
  before do
    @media = Plex::Media.new( FakeNode.new(FAKE_MEDIA_NODE_HASH) )
  end

  Plex::Media::ATTRIBUTES.map {|m| Plex.underscore(m) }.each { |method|
    it "should properly respond to ##{method}" do
      @media.send(method.to_sym).must_equal FAKE_MEDIA_NODE_HASH[method.to_sym]
    end
  }

  it "should properly respond to #parts" do
    @media.parts.must_equal Array( Plex::Part.new(FakeNode.new(FAKE_PART_NODE_HASH)) )
  end

end
