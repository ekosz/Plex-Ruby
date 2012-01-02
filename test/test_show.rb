require 'test_helper'

class TestShow < Plex::Show
  def initialize(parent, key)
    @xml_doc = FakeNode.new(FAKE_SHOW_NODE_HASH)
    super(parent, key)
  end
end


describe Plex::Show do
  before do
    @section = FakeParent.new
    @show = TestShow.new(@section, '/library/metadata/10')
  end

  Plex::Show::ATTRIBUTES.map{|m| Plex.underscore(m)}.each { |method|
    it "should properly respond to ##{method}" do
      @show.send(method.to_sym).must_equal FAKE_SHOW_NODE_HASH[:Directory].attr(method)
    end
  }

  it "should return a list of seasons" do
    @show.instance_variable_set(
      "@children", FakeNode.new(FAKE_SEASON_NODE_HASH)
    )
    @show.instance_variable_set( "@plex_season", TestSeason )
    @show.seasons.must_equal(
      [ TestSeason.new(FakeParent.new, FAKE_SEASON_NODE_HASH[:Directory].attr('key')[0..-10]) ]
    )
  end

  it "should return a spesific season" do
    @show.instance_variable_set(
      "@children", FakeNode.new(FAKE_SEASON_NODE_HASH)
    )
    @show.instance_variable_set( "@plex_season", TestSeason )
    @show.season(1).must_equal @show.seasons.first
  end

  it "should remember its parent (section)" do
    @show.section.must_equal @section
  end

end
