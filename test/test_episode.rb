require 'test_helper'

describe Plex::Episode do

  before do
    @episode = Plex::Episode.new(FakeParent.new, '/libary/metadata/6')
  end

  it "should pass the proper method calls to its video object" do
    fake_video = Plex::Video.new( FakeNode.new(FAKE_VIDEO_NODE_HASH) )
    @episode.instance_variable_set(
      "@video", fake_video
    )

    %w(studio type title title_sort content_rating summary rating view_count year 
       tagline thumb art duration originally_available_at updated_at).each { |method|
      @episode.send(method.to_sym).must_equal fake_video.send(method.to_sym)
    }
    
    @episode.media.must_equal fake_video.media

    @episode.genres.must_equal fake_video.genres

    @episode.writers.must_equal fake_video.writers

    @episode.directors.must_equal fake_video.directors

    @episode.roles.must_equal fake_video.roles

  end

end
