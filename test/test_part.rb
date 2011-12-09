require 'test_helper'

describe Plex::Part do
  before do
    @part = Plex::Part.new( FakeNode.new(FAKE_PART_NODE_HASH) )
  end

  %w(id key duration file size).each { |method|
    it "should properly respond to ##{method}" do
      @part.send(method.to_sym).must_equal FAKE_PART_NODE_HASH[method.to_sym]
    end
  }

  it "should properly respond to #streams" do
    @part.streams.must_equal Array( Plex::Stream.new(FakeNode.new(FAKE_STREAM_NODE_HASH)) )
  end

end

