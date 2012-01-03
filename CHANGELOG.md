## 0.0.1.alpha

* Initial Release
* Browsing a library works
* Sending commands to a clients works intermittently, needs lots of work

## 0.1.0

* Gem released of RubyGems

## 0.2.0

* Added documentation
* Added bang methods that clears caches
* Fix naming of 'libary' to 'library'
* Moved static content into Constants (Wow!\s)

## 0.3.0

* Now allows for multiple servers
* Fix a misspelling of 'library' that broke the gem (Sorry!)

## 0.3.1

* Fix `gem install plex-ruby`, require `open-uri` as a runtime dependency 
  wasn't a good idea

## 1.0.0

* Added a test suite that can be run with `rake`
* I feel this a production ready, will continue to add features

## 1.1.0

* Added `Plex::Section` category methods
    * ie. `library.section(2).years # [{key: '2008', title: '2008'},...]`
    * `library.section(1).by_first_letter('H') # [Plex::Movie, ...]`
    * Read the docs for more info

## 1.1.1

* Fix code breaking bug in 1.1.0

## 1.2.0

* `Plex::Client#play_media` now can take an Object that `responds_to(:key)`

## 1.3.0

* snake_case() -> underscore()
* Added Plex class method `camalize`
* Added singular season and episode methods
* Attribute methods are now dynamically created in the initializer.  This gets ride of 
  the lazy loading, but allows this gem to grow with Plex without having to update
  the code every time the API changes.

## 1.3.1

* Got rid of stdout garbage
* Fixed `Show#season` not working
* Added tests

## 1.4.0

* Switched from Array#select().first to Array#detect for performance
* Plex::Season helper methods
    * #first_episode
    * #last_episode
* Plex::Show helper methods
    * #first_season
    * #last_season
    * #special_season
    * #first_episode
    * #last_episode
* Updated Readme to use new helper methods
* Cleaned up docs by adding @private to internal public methods
