require 'test_helper'

describe Plex::Show do
  before do
    @show = Plex::Show.new(FakeParent.new, '/library/metadata/10')
    @show.instance_variable_set("@xml_doc", FakeNode.new(FAKE_SHOW_NODE_HASH))
  end

  Plex::Show::ATTRIBUTES.map{|m| Plex.snake_case(m)}.each { |method|
    it "should properly respond to ##{method}" do
      @show.send(method.to_sym).must_equal FAKE_SHOW_NODE_HASH[:Directory].attr(method)
    end
  }

  it "should return a list of episodes" do
    @show.instance_variable_set(
      "@children", FakeNode.new(FAKE_SEASON_NODE_HASH)
    )
    @show.seasons.must_equal(
      [ Plex::Season.new(FakeParent.new, FAKE_SEASON_NODE_HASH[:Directory].attr('key')[0..-10]) ]
    )
  end

end
