require 'test_helper'

describe Plex::Stream do
  before do
    @stream = Plex::Stream.new( FakeNode.new(FAKE_STREAM_NODE_HASH) )
  end

  Plex::Stream::ATTRIBUTES.map{|m| Plex.snake_case(m)}.each { |method|
    it "should properly respond to ##{method}" do
      @stream.send(method.to_sym).must_equal FAKE_STREAM_NODE_HASH[method.to_sym]
    end
  }

end


