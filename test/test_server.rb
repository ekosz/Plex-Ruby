require 'test_helper'

describe Plex::Server do
  before do
    @server = Plex::Server.new('localhost', 3000)
  end

  it "has a host" do
    @server.host.must_equal 'localhost'
  end

  it "has a port" do
    @server.port.must_equal 3000
  end

  it "properly formats its url" do
    @server.url.must_equal "http://localhost:3000"
  end

  it "has a libary" do
    @server.library.must_equal Plex::Library.new(@server)
  end

end
