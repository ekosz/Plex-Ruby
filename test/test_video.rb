require 'test_helper'

describe Plex::Video do

  before do
    @video = Plex::Video.new( FakeNode.new(FAKE_VIDEO_NODE_HASH) )
  end

  %w(key studio type title title_sort content_rating summary rating view_count year 
     tagline thumb art duration originally_available_at updated_at).each { |method|
    it "should correctly respond to ##{method}" do
      @video.send(method.to_sym).must_equal FAKE_VIDEO_NODE_HASH[method.to_sym]
    end
  }
  
  it "should correctly referance its media object" do
    @video.media.must_equal Plex::Media.new(FAKE_VIDEO_NODE_HASH[:Media])
  end

  it "should correctly referance its genre objects" do
    @video.genres.must_equal Array( Plex::Genre.new(FAKE_VIDEO_NODE_HASH[:Genre]) )
  end

  it "should correctly referance its writer objects" do
    @video.writers.must_equal Array( Plex::Writer.new(FAKE_VIDEO_NODE_HASH[:Writer]) )
  end

  it "should correctly referance its director objects" do
    @video.directors.must_equal Array( Plex::Director.new(FAKE_VIDEO_NODE_HASH[:Director]) )
  end

  it "should correctly referance its role objects" do
    @video.roles.must_equal Array( Plex::Role.new(FAKE_VIDEO_NODE_HASH[:Role]) )
  end

end
