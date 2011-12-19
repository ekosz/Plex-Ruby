# Plex-Ruby [![Build Status](https://secure.travis-ci.org/ekosz/Plex-Ruby.png)](https://secure.travis-ci.org/ekosz/Plex-Ruby.png)

A handy gem for working with Plex within Ruby.  Tries to emulate and document
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

## Usage

Everything Stems from the Plex MediaServer. Create a server with the host and
port number.

```ruby
server = Plex::Server.new(CONFIG[:host], CONFIG[:port])
```

From here we can start doing cool things. Lets pause whats currently playing.

```ruby
clients = server.clients
client = # pick the media player you want
client.pause # That was easy
````

Lets search the libary.

```ruby
sections = server.library.sections
section = # Pick the section you want I.E. TV, Movies, Home Videos
shows = section.all # Returns a list of shows/movies
bsg = shows.select { |s| s.title =~ /Battlestar/ }.first # Pick a great show
bsg.seasons # array of its seasons
episodes = bsg.seasons.last.episodes # Array the last seasons episodes
episode = episodes[4] # The fifth episode in the season
puts "#{episode.title} - #{episode.summary}" # Looks good
client.play_media(episode) # Play it!
```

For a full list of commands check out the [documentation](http://rubydoc.info/github/ekosz/Plex-Ruby/master/frames).

## Development

All development of this gem takes place on its GitHub page. There you can
create issues or submit pull requests.

When submiting a pull request please write tests for your changes as well as
use feature branches. Thank you!

This gem was created by Eric Koslow and is under the MIT Licence.
