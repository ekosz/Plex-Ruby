# Plex-Ruby [![Build Status](https://secure.travis-ci.org/ekosz/Plex-Ruby.png)](https://secure.travis-ci.org/ekosz/Plex-Ruby)

A handy gem for working with [Plex Media Player](http://plexapp.com) within Ruby.  Tries to emulate and document
all of the Plex APIs using simple ruby code.  I will try and keep it as
up-to-date as possible, but pull requests are always welcomed.


## Installation

Add to your `Gemfile` and run the `bundle` command

```ruby
gem 'plex-ruby'
```

Or

```ruby
gem install plex-ruby

require 'plex-ruby'
```

I developed this using Ruby 1.9.2 so no guaranties that it will work with
lesser versions of Ruby.

## Configuration

For external access to your Plex Media Server an auth token is required. You
can configure it with the following snippet.

```ruby
Plex.configure do |config|
  config.auth_token = "ABCDEFGH"
end
```

## Usage

Everything Stems from the Plex Media Server. Create a server with the host and
port number.

```ruby
server = Plex::Server.new(CONFIG[:host], CONFIG[:port])
```

From here we can start doing cool things. Lets pause whats currently playing.

```ruby
clients = server.clients  # list of all connected clients
client =                  # pick the media player you want
client.pause              # That was easy
````

Lets search the libary.

```ruby
sections = server.library.sections
section =                                           # Pick the section you want I.E. TV, Movies, Home Videos
shows = section.all                                 # Returns a list of shows/movies
bsg = shows.detect { |s| s.title =~ /Battlestar/ }  # Pick a great show
season = bsg.last_season                            # Pick the last season
episode = season.episode(5)                         # The fifth episode in the season
puts "#{episode.title} - #{episode.summary}"        # Looks good
client.play_media(episode)                          # Play it!
```

You can also use the `attribute_hash` method on an object to get a full list of
attributes.

```ruby
pp episode.attribute_hash
#=>
#{"rating_key"=>"23",
# "key"=>"/library/metadata/23",
# "guid"=>"com.plexapp.agents.thetvdb://73545/1/13?lang=en",
# "type"=>"episode",
# "title"=>"Kobol's Last Gleaming (2)",
# "summary"=>
#  "When Commander Adama learns that Kara disobeyed orders and Jumped to Caprica on orders from President Roslin, he demands the president's resignation, with the implied threat of a military coup. Roslin refuses his demand and sparks a confrontation.",
# "index"=>"13",
# "rating"=>"8.3",
# "year"=>"2005",
# "thumb"=>"/library/metadata/23/thumb?t=1323220437",
# "originally_available_at"=>"2005-01-24",
# "added_at"=>"1323213639",
# "updated_at"=>"1323220437"}
```

For a full list of commands check out the [documentation](http://rubydoc.info/github/ekosz/Plex-Ruby/master/frames).

## Development

All development of this gem takes place on its GitHub page. There you can
create issues or submit pull requests.

When submiting a pull request please write tests for your changes as well as
use feature branches. Thank you!

This gem was created by Eric Koslow and is under the MIT Licence.
