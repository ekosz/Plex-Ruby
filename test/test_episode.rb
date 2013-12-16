require 'test_helper'

class TestEpisode < Plex::Episode
  def initialize(parent, key)
    @xml_doc = FakeNode.new({Video: FakeNode.new(FAKE_VIDEO_NODE_HASH)})
    super(parent, key)
  end
end

describe Plex::Episode do

  before do
    @season = FakeParent.new
    @episode = Plex::Episode.new(@season, '/libary/metadata/6')
  end

  it "should pass the proper method calls to its video object" do
    fake_video = Plex::Video.new( FakeNode.new(FAKE_VIDEO_NODE_HASH) )
    @episode.instance_variable_set(
      "@video", fake_video
    )

    (Plex::Video::ATTRIBUTES - %w(key)).map {|m| Plex.underscore(m) }.each { |method|
      @episode.send(method.to_sym).must_equal fake_video.send(method.to_sym)
    }

    @episode.medias.must_equal fake_video.medias

    @episode.genres.must_equal fake_video.genres

    @episode.writers.must_equal fake_video.writers

    @episode.directors.must_equal fake_video.directors

    @episode.roles.must_equal fake_video.roles

  end

  it "should remember its parent (season)" do
    @episode.season.must_equal @season
  end

end
