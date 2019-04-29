require 'plex-ruby'
require 'minitest/autorun'

class FakeAttr
  def initialize(val)
    @val = val
  end

  def value
    @val
  end
end

class FakeNode
  def initialize(hash)
    @hash = hash
  end

  def attr(value)
    @hash[Plex.underscore(value).to_sym]
  end

  def attributes
    @hash.each_with_object({}) do |(key, val), obj|
      obj[Plex.camelize(key)] = FakeAttr.new(val)
    end
  end

  def search(value)
    Array(@hash[value.to_sym])
  end
end

class FakeParent
  def url
    'http://localhost:32400'
  end
end

FAKE_CLIENT_NODE_HASH = {
  name: 'koslow.office',
  host: '10.0.0.24',
  address: '10.0.0.24',
  port: '3000',
  machine_identifier: 'f11283e2-a274-4c86-9a0a-23336c2d9e53',
  version: '0.9.5.2-06ca164',
}.freeze

FAKE_SHOW_NODE_HASH = {
  Directory: FakeNode.new(
    rating_key: '9',
    guid: 'com.plexapp.agents.thetvdb://73545?lang=en',
    studio: 'SciFi',
    type: 'show',
    title: 'Battlestar Galactica (2003)',
    content_rating: 'TV-14',
    summary: 'In a distant part of the universe, a civilization of humans live on planets known as the Twelve Colonies. In the past, the Colonies have been at war with a cybernetic race known as the Cylons. 40 years after the first war the Cylons launch a devastating attack on the Colonies. The only military ship that survived the attack takes up the task of leading a small fugitive fleet of survivors into space in search of a fabled refuge known as Earth.',
    index: '1',
    rating: '9.3',
    year: '2003',
    thumb: '/library/metadata/9/thumb?t=1323220437',
    art: '/library/metadata/9/art?t=1323220437',
    banner: '/library/metadata/9/banner?t=1323220437',
    theme: '/library/metadata/9/theme?t=1323220437',
    duration: '3600000',
    originally_available_at: '2003-12-08',
    leaf_count: '13',
    viewed_leaf_count: '0',
    added_at: '1323213639',
    updated_at: '1323220437')
}.freeze

FAKE_SEASON_NODE_HASH = {
  Directory: FakeNode.new(
    rating_key: '10',
    key: '/library/metadata/10/children',
    guid: 'com.plexapp.agents.thetvdb://73545/1?lang=en',
    type: 'season',
    title: 'Season 1',
    summary: '',
    index: '1',
    thumb: '/library/metadata/10/thumb?t=1323220437',
    leaf_count: '13',
    viewed_leaf_count: '0',
    added_at: '1323213639',
    updated_at: '1323220437')
}.freeze

FAKE_SECTION_NODE_HASH = {
  refreshing: '0',
  key: '1',
  type: 'movie',
  title: 'Movies',
  art: '/:/resources/movie-fanart.jpg',
  agent: 'com.plexapp.agents.imdb',
  scanner: 'Plex Movie Scanner',
  language: 'en',
  updated_at: '1323213684',
}.freeze

FAKE_LIBRARY_NODE_HASH = {
  :Directory => FakeNode.new(FAKE_SECTION_NODE_HASH),
  :"Directory[@key='#{FAKE_SECTION_NODE_HASH[:key]}.freeze']" =>  FakeNode.new(FAKE_SECTION_NODE_HASH),
}.freeze

FAKE_STREAM_NODE_HASH = {
  id: '100',
  stream_type: 'fast',
  codec: 'aac',
  index: '5',
  language: 'English',
  language_code: 'en',
}.freeze

FAKE_PART_NODE_HASH = {
  id: '45',
  key: '1',
  duration: '1600',
  file: '/some/file/path/blah.mkv',
  size: '6500',
  Stream: FakeNode.new(FAKE_STREAM_NODE_HASH),
}.freeze

FAKE_MEDIA_NODE_HASH = {
  id: '63',
  durration: '3200',
  bitrate: '24p',
  aspect_ratio: '4:3',
  audio_channels: '2',
  audio_codec: 'mp3',
  video_codec: 'mp4',
  video_resolution: '720p',
  container: 'mkv',
  video_frame_rate: '32/2',
  Part: FakeNode.new( FAKE_PART_NODE_HASH )
}.freeze

FAKE_GENRE_NODE_HASH = {
  id: '13',
  tag: 'Action',
}.freeze

FAKE_WRITER_NODE_HASH = {
  id: '14',
  tag: 'Poe',
}.freeze

FAKE_DIRECTOR_NODE_HASH = {
  id: '15',
  tag: 'King',
}.freeze

FAKE_ROLE_NODE_HASH = {
  id: '16',
  tag: 'Red Haired Person',
  role: 'Ron',
}.freeze

FAKE_VIDEO_NODE_HASH = {
  rating_key: '7',
  key: '/library/7',
  studio: 'Six',
  type: 'movie',
  title: 'Men in Black (2011)',
  title_sort: 'Men in Black',
  content_rating: 'MA',
  summary: 'Two men fight the entire world!',
  rating: '9.9',
  view_count: '0',
  year: '2011',
  tagline: 'Fight the Power!',
  thumb: '/some/long/filename.jpg',
  art: '/some/other/long/filename.jpg',
  duration: '3400',
  originally_available_at: '324124',
  updated_at: '342214',
  index: '1',
  Media: FakeNode.new(FAKE_MEDIA_NODE_HASH),
  Genre: FakeNode.new(FAKE_GENRE_NODE_HASH),
  Writer: FakeNode.new(FAKE_WRITER_NODE_HASH),
  Director: FakeNode.new(FAKE_DIRECTOR_NODE_HASH),
  Role: FakeNode.new(FAKE_ROLE_NODE_HASH),
}.freeze

FAKE_PARSER_NODE_HASH = {
  MediaContainer: FakeNode.new(FAKE_VIDEO_NODE_HASH),
}.freeze
