require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  def reset_albums_table
    seed_sql = File.read('spec/seeds/albums_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end

  def reset_artists_table
    seed_sql = File.read('spec/seeds/artists_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end
  
  describe Application do
    before(:each) do 
      reset_albums_table
      reset_artists_table
    end

  context "POST /" do
    xit 'should add new album to albums' do
      response = post(
        '/albums', 
      title: 'Voyage', 
      release_year: '2022', 
      artist_id: '2' 
      )

      expect(response.status).to eq(200)
      expect(response.body).to eq ("")

      response = get('/albums')
      expect(response.status).to eq(200)
      expect(response.body).to include("Voyage")
    end

    xit 'adds a new artist to artists' do
      # Assuming the post with id 1 exists.
      response = post('/artists', 
      name: 'Wild nothing',
      genre: 'Indie'
      )

      expect(response.status).to eq(200)
      expect(response.body).to eq ("")

      response = get('/artists')
      expect(response.status).to eq(200)
      expect(response.body).to include("Wild nothing")
    end
  end

  context "GET /artists" do
    xit 'return a list of artists' do
      # Assuming the post with id 1 exists.
      response = get('/artists')

      expect(response.status).to eq(200)
      expect(response.body).to include ("Pixies, ABBA, Taylor Swift, Nina Simone")
    end

    it 'returns 404 Not Found' do
      response = get('/musicians')

      expect(response.status).to eq(404)
      expect(response.body).to eq("Sorry! We couldn't find this record. Have a look at the homepage?")
    end
  end

  context "GET /albums" do
    it 'returns a page with album information' do
      response = get('/albums')

      expect(response.status).to eq(200)
      expect(response.body).to include('Surfer Rosa')
      expect(response.body).to include('Fodder on My Wings')
      expect(response.body).to include('/albums/3')
    end
  end

  context 'GET /albums/:id' do
    it 'returns info about 1 album' do
      response = get('/albums/2')
      expect(response.status).to eq(200)
      expect(response.body).to include ('<h1>Surfer Rosa</h1>')
      expect(response.body).to include ('Release year: 1988')
      expect(response.body).to include ('Artist: Pixies')
    end
  end

  context "GET /artists/:id" do
    it 'returns a page with artist information' do
      response = get('/artists/1')

      expect(response.status).to eq(200)
      expect(response.body).to include('Name: Pixies')
      expect(response.body).to include('Genre: Rock')
    end

    it 'returns a page with artist information' do
      response = get('/artists/4')

      expect(response.status).to eq(200)
      expect(response.body).to include('Name: Nina Simone')
      expect(response.body).to include('Genre: Pop')
    end
  end

  context "GET /artists with links" do
    it 'returns a page showing all artist information with links' do
      response = get('/artists')

      expect(response.status).to eq(200)
      expect(response.body).to include('Name: Pixies')
      expect(response.body).to include('/artists/1')
    end

    it 'returns a page with artist information' do
      response = get('/artists')

      expect(response.status).to eq(200)
      expect(response.body).to include('Name: ABBA')
      expect(response.body).to include('/artists/2')
    end
  end

  context "GET /albums/new" do
    it 'returns the form page' do
      response = get('/albums/new')
  
      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Add a new album</h1>')
  
      # Assert we have the correct form tag with the action and method.
      expect(response.body).to include('<form action="/albums" method="POST">')
  
      # We can assert more things, like having
      # the right HTML form inputs, etc.
    end
  end
  
  context "POST /albums" do
    it 'returns a success page' do
      # We're now sending a POST request,
      # simulating the behaviour that the HTML form would have.
      response = post(
        '/albums',
        title: 'Hopes and Fears',
        release_year: '2006'
      )
  
      expect(response.status).to eq(200)
      expect(response.body).to include('Your album has been added!')
    end
  end

  context "GET /artists/new" do
    it 'returns the form page' do
      response = get('/artists/new')
  
      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Add a new artist</h1>')
  
      # Assert we have the correct form tag with the action and method.
      expect(response.body).to include('<form action="/artists" method="POST">')
  
      # We can assert more things, like having
      # the right HTML form inputs, etc.
    end
  end
  
  context "POST /artists" do
    it 'returns a success page' do
      # We're now sending a POST request,
      # simulating the behaviour that the HTML form would have.
      response = post(
        '/artists',
        name: 'Keane',
        genre: 'Pop'
      )
  
      expect(response.status).to eq(200)
      expect(response.body).to include('Your artist has been added!')
    end
  end



end

end
