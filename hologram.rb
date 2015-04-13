require 'sinatra'
require 'data_mapper'

DataMapper.setup(:default, "sqlite3:database.sqlite3")

class Song
  include DataMapper::Resource
  property :id, Serial
  property :song_name, String
  property :artist, String
  property :mood, String
  property :link, String
end

DataMapper.finalize
DataMapper.auto_upgrade!

get '/' do
  @hologram_name = "Fly Me to the Moon"
  erb :index, :layout => :minimal
end

get '/songs' do
  @songs = Song.all
  puts @songs
  erb :songs
end

get '/song_request' do
  erb :song_request
end


get "/songs/:id" do
  @song = Song.get(params[:id])
  if @song
    erb :show_song
  else
    raise Sinatra::NotFound
  end
end

get "/songs/:id/edit" do
  @song = Song.get(params[:id])
  if @song
    erb :edit_song
  else
    raise Sinatra::NotFound
  end
end

put "/songs/:id" do
  @song = Song.get(params[:id])
  if @song
    @song.song_name = params[:song_name]
    @song.artist = params[:artist]
    @song.mood = params[:mood]
    @song.link = params[:link]
    @song.save
    redirect to("/songs")
  else
    raise Sinatra::NotFound
  end
end

delete "/songs/:id" do
  @song = Song.getparams([:id])
  if @song
    @songs.delete(@song)
    redirect to("/songs")
  else
    raise Sinatra::NotFound
  end
end

post '/songs' do
  song = Song.create(:song_name => params[:song_name],
    :artist => params[:artist],
    :mood => params[:mood],
    :link => params[:link])
  redirect to("/songs")
end