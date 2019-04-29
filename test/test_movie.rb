require 'test_helper'

describe Plex::Movie do
  before do
    @section = FakeParent.new
    @movie = Plex::Movie.new(@section, '/libary/metadata/6')
  end

  it "should pass the proper method calls to its video object" do
    fake_video = Plex::Video.new( FakeNode.new(FAKE_VIDEO_NODE_HASH) )
    @movie.instance_variable_set(
      "@video", fake_video
    )

    (Plex::Video::ATTRIBUTES - %w(key)).map {|m| Plex.underscore(m) }.each { |method|
      @movie.send(method.to_sym).must_equal fake_video.send(method.to_sym)
    }

    @movie.medias.must_equal fake_video.medias
    assert_instance_of Plex::Media, @movie.medias.first

    @movie.genres.must_equal fake_video.genres
    assert_instance_of Plex::Genre, @movie.genres.first

    @movie.writers.must_equal fake_video.writers
    assert_instance_of Plex::Writer, @movie.writers.first

    @movie.directors.must_equal fake_video.directors
    assert_instance_of Plex::Director, @movie.directors.first

    @movie.roles.must_equal fake_video.roles
    assert_instance_of Plex::Role, @movie.roles.first

    @movie.collections.must_equal fake_video.collections
    assert_instance_of Plex::Collection, @movie.collections.first
  end

  it "should remember its parent (section)" do
    @movie.section.must_equal @section
  end

end
