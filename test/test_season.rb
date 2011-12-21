require 'test_helper'

class TestSeason < Plex::Season
  def initialize(parent, key)
    @xml_doc = FakeNode.new(FAKE_SEASON_NODE_HASH)
    super(parent, key)
  end
end

describe Plex::Season do
  before do
    @show = FakeParent.new
    @season = TestSeason.new(@show, '/library/metadata/10')
  end

  Plex::Season::ATTRIBUTES.map{|m| Plex.underscore(m)}.each { |method|
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

  it "should remember its parent (show)" do
    @season.show.must_equal @show
  end

end
