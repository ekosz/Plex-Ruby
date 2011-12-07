# Plex-Ruby

A handy gem for working with Plex within Ruby.  Tries to emulate and document
all of the Plex APIs using simple ruby code.  I will try and keep it as
up-to-date as possible, but pull requests are always welcomed.


## Instaltion

Add to your `Gemfile` and run the `bundle` command

```ruby
gem 'plex-ruby'
```

I developed this using Ruby 1.9.2 so no garrenties that it will work with
lesser versions of Ruby.

## Usage

Everything Stems from the Plex MediaServer. Create a server with the host and
port number.

```ruby
server = Plex::Server.new(CONFIG[:host], CONFIG[:port])
```

From here we can start doing cool things. Lets pause whats currently playing.

```ruby
players = server.system.players
player = # pick the media player you want
player.pause # That was easy
````

For a full list of commands check out the documentation.

## Developement

All development of this gem takes place on its GitHub page. There you can
create issues or submit pull requests.

When submiting a pull request please write tests for your changes as well as
use feature branches. Thank you!

This gem was created by Eric Koslow and is under the MIT Licence.
