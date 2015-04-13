class Song
  # include DataMapper::Resource
  # property :id, Serial
  # property :song_name String
  # property :artist String
  # property :mood String
  # property :link String
# end

# DataMapper.finalize
# DataMapper.auto_upgrade!

  attr_accessor :id, :artist, :song_name, :mood, :link

  def initialize(song_name, artist, mood, link  )
    @artist = song_name
    @song_name = artist
    @mood = mood
    @link = link
  end
end