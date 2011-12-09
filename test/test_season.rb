require 'test_helper'

describe Plex::Season do
  before do
    @season = Plex::Season.new(FakeParent.new, '/library/metadata/10')
    @season.instance_variable_set("@xml_doc", FakeNode.new(FAKE_SEASON_NODE_HASH))
  end

  Plex::Season::ATTRIBUTES.map{|m| Plex.snake_case(m)}.each { |method|
    it "should properly respond to ##{method}" do
      @season.send(method.to_sym).must_equal FAKE_SEASON_NODE_HASH[:Directory].attr(method)
    end
  }

  it "should return a list of episodes" do
    @season.instance_variable_set(
      "@children", FakeNode.new({Video: FakeNode.new(FAKE_VIDEO_NODE_HASH)})
    )
    @season.episodes.must_equal(
      [ Plex::Episode.new(FakeParent.new, FAKE_VIDEO_NODE_HASH[:key]) ]
    )
  end

end
