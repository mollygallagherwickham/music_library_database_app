# file: app.rb
require 'sinatra'
require "sinatra/reloader"
require_relative 'lib/database_connection'
require_relative 'lib/album_repository'
require_relative 'lib/artist_repository'

DatabaseConnection.connect

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/album_repository'
    also_reload 'lib/artist_repository'
  end

  get '/albums/new' do
    return erb(:new_album)
  end

  post '/albums' do
    if invalid_album_request_parameters?
      status 400
      return ''
    end

      title = params[:title]
      release_year = params[:release_year]

      new_album = Album.new
      new_album.title = title
      new_album.release_year = release_year
      album_repo.create(new_album)

      return erb(:album_created)
      return ''

    end

  def invalid_album_request_parameters?
    params[:title] == nil || params[:release_year] == nil || params[:title] =~ special_characters || params[:release_year] =~ special_characters
  end

  get '/albums/:id' do
    @album = album_repo.find(params[:id])
    @artist = artist_repo.find(@album.artist_id)

    return erb(:album)
  end

  get '/albums' do
    @albums = album_repo.all
    
    return erb(:albums)
  end

  get '/artists/new' do
    return erb(:new_artist)
  end

  post '/artists' do
    if invalid_artist_request_parameters?
      status 400
      
      return ''
    end

    name = params[:name]
    genre = params[:genre]

    new_artist = Artist.new
    new_artist.name = name
    new_artist.genre = genre
    artist_repo.create(new_artist)

    return erb(:artist_created)
    return ''
  end

  def invalid_artist_request_parameters?
    params[:name] == nil || params[:genre] == nil || params[:name] =~ special_characters || params[:genre] =~ special_characters
  end


  get '/artists/:id' do
    @artist = artist_repo.find(params[:id])
    return erb(:artist)
  end

  get '/artists' do
    @artists = artist_repo.all
    return erb(:artists)
  end

  get '/' do
    return erb(:index)
  end

  not_found do
    return "Sorry! We couldn't find this record. Have a look at the homepage?"
  end


  def artist_repo
    ArtistRepository.new
  end

  def album_repo
    AlbumRepository.new
  end

  def special_characters
    special_characters = /[@£$%^*<>]/
  end
end
file.write "\n"
