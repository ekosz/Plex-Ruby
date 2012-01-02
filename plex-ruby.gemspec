# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "plex-ruby/version"

Gem::Specification.new do |s|
  s.name        = "plex-ruby"
  s.version     = Plex::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Eric Koslow"]
  s.email       = ["ekoslow@gmail.com"]
  s.homepage    = "https://github.com/ekosz/Plex-Ruby"
  s.summary     = %q{Plex Media Server APIs in easy ruby code}
  s.description = %q{Extracts the Plex Media Server API into easy to write ruby code}

  s.rubyforge_project = "plex-ruby"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency 'minitest'
  s.add_development_dependency "rake"
  s.add_development_dependency "fakeweb"
  s.add_runtime_dependency 'nokogiri'
end
