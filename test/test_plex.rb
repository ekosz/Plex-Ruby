require 'test_helper'

describe Plex do

  it "converts words from camelCase to underscore" do
    Plex.underscore("camelCase").must_equal "camel_case"
    Plex.underscore("snake_case").must_equal "snake_case"
    Plex.underscore("normal").must_equal "normal"
  end

  before do
    FakeWeb.register_uri(:get, "http://localhost:32400", :body => "")
  end

  after do
    FakeWeb.clean_registry
    Plex.config.auth_token = nil
  end

  it "has an open function which respects the configuration" do
    Plex.configure {|config| config.auth_token = "ABCD" }

    Plex.open("http://localhost:32400").read
    FakeWeb.last_request["X-Plex-Token"].must_equal "ABCD"
  end
end
