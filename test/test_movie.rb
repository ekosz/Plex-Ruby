require 'test_helper'

describe Plex::Movie do

  before do
    @movie = Plex::Movie.new(FakeParent.new, '/libary/metadata/6')
  end

  it "should pass the proper method calls to its video object" do
    fake_video = Plex::Video.new( FakeNode.new(FAKE_VIDEO_NODE_HASH) )
    @movie.instance_variable_set(
      "@video", fake_video
    )

    %w(studio type title title_sort content_rating summary rating view_count year 
       tagline thumb art duration originally_available_at updated_at).each { |method|
      @movie.send(method.to_sym).must_equal fake_video.send(method.to_sym)
    }
    
    @movie.media.must_equal fake_video.media

    @movie.genres.must_equal fake_video.genres

    @movie.writers.must_equal fake_video.writers

    @movie.directors.must_equal fake_video.directors

    @movie.roles.must_equal fake_video.roles

  end

end
