require 'sinatra'
require_relative 'playlist'
require_relative 'song'
# require 'data_mapper'

$playlist = Playlist.new

# DataMapper.setup(:default, "sqlite3:database.sqlite3"

get '/' do
  @hologram_name = "Fly Me to the Moon"
  erb :index
end

get '/songs' do
    erb :songs
end

get '/song_request' do
  erb :song_request
end


get "/songs/:id" do
  @song = $playlist.find(params[:id].to_i)
  if @song
    erb :show_song
  else
    raise Sinatra::NotFound
  end
end

get "/songs/:id/edit" do
  @song = $playlist.find( params[ :id ].to_i )
  if @song
    erb :edit_song
  else
    raise Sinatra::NotFound
  end
end

put "/songs/:id" do
  @song = $playlist.find(params[:id].to_i)
  if @song
    @song.song_name = params[:song_name]
    @song.artist = params[:artist]
    @song.mood = params[:mood]
    @song.link = params[:link]

    redirect to("/songs")
  else
    raise Sinatra::NotFound
  end
end

delete "/songs/:id" do
  @song = $playlist.find(params[:id].to_i)
  if @song
    $playlist.remove_song(@song)
    redirect to("/songs")
  else
    raise Sinatra::NotFound
  end
end

post '/songs' do
  @song = Song.new(params[:song_name], params[:artist], params[:mood], params[:link])
  $playlist.request_song(@song)
  redirect to('/songs')
end