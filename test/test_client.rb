require 'test_helper'
require 'fakeweb'

describe Plex::Client do
  before do
    @server = FakeParent.new
    @client = Plex::Client.new(@server, FakeNode.new(FAKE_CLIENT_NODE_HASH))
    FakeWeb.register_uri(:get, %r|http://localhost:32400|, :body => "")
  end

  after do
    FakeWeb.clean_registry
  end

  Plex::Client::NAV_METHODS.each { |method|
    it "should properly communicate its ##{Plex.snake_case(method)} method" do
      assert @client.send(Plex.snake_case(method).to_sym)
      FakeWeb.last_request.path.must_equal "/system/players/#{@client.name}/navigation/#{method}"
    end
  }

  Plex::Client::PLAYBACK_METHODS.each { |method|
    it "should properly communicate its ##{Plex.snake_case(method)} method" do
      assert @client.send(Plex.snake_case(method).to_sym)
      FakeWeb.last_request.path.must_equal "/system/players/#{@client.name}/playback/#{method}"
    end
  }

  it "should properly commnicate its  #play_file method" do
    assert @client.play_file
    FakeWeb.last_request.path.must_equal "/system/players/#{@client.name}/application/playFile"
  end

  it "should properly commnicate its  #play_media method" do
    key = '/metadata/10'
    assert @client.play_media(key)
    FakeWeb.last_request.path.must_equal(
      "/system/players/#{@client.name}/application/playMedia?path=#{CGI::escape(@client.url+key)}&key=#{CGI::escape(key)}"
    )
  end

  it "should properly commnicate its  #screenshot method" do
    assert @client.screenshot(100, 100, 75)
    FakeWeb.last_request.path.must_equal(
      "/system/players/#{@client.name}/application/screenshot?width=100&height=100&quality=75"
    )
  end

  it "should properly commnicate its  #send_string method" do
    assert @client.send_string(35)
    FakeWeb.last_request.path.must_equal(
      "/system/players/#{@client.name}/application/sendString?text=35"
    )
  end

  it "should properly commnicate its  #send_key method" do
    assert @client.send_key(70)
    FakeWeb.last_request.path.must_equal(
      "/system/players/#{@client.name}/application/sendKey?code=70"
    )
  end

  it "should properly commnicate its  #send_virtual_key method" do
    assert @client.send_virtual_key(70)
    FakeWeb.last_request.path.must_equal(
      "/system/players/#{@client.name}/application/sendVirtualKey?code=70"
    )
  end

  it "should remember its parent (server)" do
    @client.server.must_equal @server
  end

end


