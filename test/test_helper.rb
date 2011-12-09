require 'plex-ruby'
require 'minitest/autorun'


class FakeNode

  def initialize(hash)
    @hash = hash
  end

  def attr(value)
    @hash[Plex.snake_case(value).to_sym]
  end

  def search(value)
    Array( @hash[value.to_sym] )
  end

end

class FakeParent

  def url
    'http://localhost:32400'
  end

end

FAKE_SHOW_NODE_HASH = {
  Directory: FakeNode.new({
    guid: 'com.plexapp.agents.thetvdb://73545/1?lang=en',
    studio: 'Big Dog',
    title: 'Friends',
    content_rating: 'MV-14',
    summary: '3 friends go on an adventure',
    index: '1',
    rating: '10',
    year: '3033',
    thumb: '/file/path.jpg',
    art: '/other/file/path.png',
    banner: '/yet/another/file/path.jpg2000',
    theme: 'Chrismasy?',
    duration: '2345234',
    originally_available_at: '1323213639',
    leaf_count: '1',
    viewed_leaf_count: '0',
    added_at: '1323213639',
    updated_at: '1323220437',
  })
}

FAKE_SEASON_NODE_HASH = {
  Directory: FakeNode.new({
    key: '/library/metadata/10/children',
    rating_key: '10',
    guid: 'com.plexapp.agents.thetvdb://73545/1?lang=en', 
    type: 'season',
    title: 'Season 1',
    summary: '',
    index: '1',
    thumb: '/library/metadata/10/thumb?t=1323220437',
    leaf_count: '13',
    viewed_leaf_count: '0',
    added_at: '1323213639',
    updated_at: '1323220437'
  })
}

FAKE_SECTION_NODE_HASH = {
  refreshing: '0',
  key: '1',
  type: 'movie',
  title: 'Movies',
  art: '/:/resources/movie-fanart.jpg',
  agent: 'com.plexapp.agents.imdb',
  scanner: 'Plex Movie Scanner',
  language: 'en',
  updated_at: '1323213684'
}

FAKE_LIBRARY_NODE_HASH = {
  :Directory => FakeNode.new(FAKE_SECTION_NODE_HASH),
  :"Directory[@key='#{FAKE_SECTION_NODE_HASH[:key]}']" =>  FakeNode.new(FAKE_SECTION_NODE_HASH)
}

FAKE_STREAM_NODE_HASH = {
  id: '100',
  stream_type: 'fast',
  codec: 'aac',
  index: '5',
  language: 'English',
  language_code: 'en'
}

FAKE_PART_NODE_HASH = {
  id: '45',
  key: '1',
  duration: '1600',
  file: '/some/file/path/blah.mkv',
  size: '6500',
  Stream: FakeNode.new( FAKE_STREAM_NODE_HASH )
}

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
}

FAKE_GENRE_NODE_HASH = {
  id: '13',
  tag: 'Action'
}

FAKE_WRITER_NODE_HASH = {
  id: '14',
  tag: 'Poe'
}

FAKE_DIRECTOR_NODE_HASH = {
  id: '15',
  tag: 'King'
}

FAKE_ROLE_NODE_HASH = {
  id: '16',
  tag: 'Red Haired Person',
  role: "Ron"
}

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
  Media: FakeNode.new( FAKE_MEDIA_NODE_HASH ), 
  Genre: FakeNode.new( FAKE_GENRE_NODE_HASH ), 
  Writer: FakeNode.new( FAKE_WRITER_NODE_HASH ),
  Director: FakeNode.new( FAKE_DIRECTOR_NODE_HASH ), 
  Role: FakeNode.new( FAKE_ROLE_NODE_HASH )
}

FAKE_PARSER_NODE_HASH = {
  MediaContainer: FakeNode.new(FAKE_VIDEO_NODE_HASH)
}
