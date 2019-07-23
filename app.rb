require('sinatra')
require('sinatra/reloader')
require('./lib/album')
require('pry')
also_reload('lib/**/*.rb')

get ('/') do
  @albums = Album.all
  erb(:albums)
end

get ('/albums') do
  @albums = Album.all
  erb(:albums)
end

get ('/albums/new') do
  erb(:new_album)
end

post ('/albums') do
  name = params[:album_name]
  artist = params[:album_artist]
  genre = params[:album_genre]
  year = params[:album_year]
  album = Album.new(name, artist, genre, year, nil)
  album.save()
  @albums = Album.all()
  erb(:albums)
end

get ('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  erb(:album)
end


post ('/albums_search') do
  name = params[:search]
  @albums = Album.search(name)
  erb(:album_results)
end

get ('/albums/:id/edit') do
  @album = Album.find(params[:id].to_i())
  erb(:edit_album)
end

patch ('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  @album.update(params[:name, :artist, :genre, :year])
  @albums = Album.all
  erb(:albums)
end

delete ('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  @album.delete()
  @albums = Album.all
  erb(:albums)
end
#
# get ('/custom_route') do
#   "We can even create custom routes, but we should only do this when needed."
# end
