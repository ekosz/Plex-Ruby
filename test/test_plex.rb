require 'test_helper'

describe Plex do

  it "converts words from camelCase to snake_case" do
    Plex.snake_case("camelCase").must_equal "camel_case"
    Plex.snake_case("snake_case").must_equal "snake_case"
    Plex.snake_case("normal").must_equal "normal"
  end

end
