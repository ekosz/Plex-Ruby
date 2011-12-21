require 'test_helper'

describe Plex do

  it "converts words from camelCase to underscore" do
    Plex.underscore("camelCase").must_equal "camel_case"
    Plex.underscore("snake_case").must_equal "snake_case"
    Plex.underscore("normal").must_equal "normal"
  end

end
