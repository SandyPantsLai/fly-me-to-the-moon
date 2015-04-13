class Playlist
  attr_reader :songs

  def initialize
    @songs = []
    @id = 0
  end

  def request_song(song)
    song.id = @id
    @songs << song
    @id += 1
  end

  def find(song_id)
    @songs.find {|song| song.id == song_id }
  end

  def remove_song(song)
    @songs.delete(song)
  end
end