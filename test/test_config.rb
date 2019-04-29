require 'test_helper'

describe Plex::Config do

  it "should be configurable" do
    Plex.config.auth_token.assert_nil

    Plex.configure do |config|
      config.auth_token = "ABCD"
    end

    Plex.config.auth_token.must_equal "ABCD"
  end
end
