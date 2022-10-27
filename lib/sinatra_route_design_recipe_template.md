# {{ METHOD }} {{ PATH}} Route Design Recipe

_Copy this design recipe template to test-drive a Sinatra route._

## 1. Design the Route Signature

You'll need to include:
  * the HTTP method
  * the path
  * any query parameters (passed in the URL)
  * or body parameters (passed in the request body)


# Request:
GET /albums/new

# Expected response (200 OK)
Returns a form to add a new album

# Additional request
POST /albums/new 

# Expected response (200 OK)
Returns a string "Your post has been added"


## 2. Design the Response

The route might return different responses, depending on the result.

For example, a route for a specific blog post (by its ID) might return `200 OK` if the post exists, but `404 Not Found` if the post is not found in the database.

Your response might return plain text, JSON, or HTML code. 

_Replace the below with your own design. Think of all the different possible responses your route will return._

```html
<!-- Request: POST /artists name=Wild nothing, genre=Indie-->
<!-- Response when the artist is found: 200 OK -->


<!-- GET /albums/new -->

<form action="/albums/new" method="POST">
  <input type="text" name="title">
  <input type="text" name="release_year">

  <input type="submit" value="Submit the form">
</form>

```

## 3. Write Examples

_Replace these with your own design._

```
# Request:

GET /albums/new

Response for 200 OK

include '<h1>Add an album</h1>'
include '<form action="/albums/new" method="POST">'
```
# Request:

POST /albums/new

Response for 200 OK

include '<p>Your post has been added!</p>'
```

```

## 4. Encode as Tests Examples

```ruby
# EXAMPLE
# file: spec/integration/application_spec.rb

require "spec_helper"

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

context "GET /albums/new" do
  it 'returns the form page' do
    response = get('/albums/new')

    expect(response.status).to eq(200)
    expect(response.body).to include('<h1>Add an album</h1>')

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
    expect(response.body).to include('<p>Your album has been added!</p>')
  end

  it 'responds with 400 status if parameters are invalid' do
    # ...
  end
end
end

```

## 5. Implement the Route

Write the route and web server code to implement the route behaviour.

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->

---

**How was this resource?**  
[😫](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fweb-applications&prefill_File=resources%2Fsinatra_route_design_recipe_template.md&prefill_Sentiment=😫) [😕](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fweb-applications&prefill_File=resources%2Fsinatra_route_design_recipe_template.md&prefill_Sentiment=😕) [😐](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fweb-applications&prefill_File=resources%2Fsinatra_route_design_recipe_template.md&prefill_Sentiment=😐) [🙂](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fweb-applications&prefill_File=resources%2Fsinatra_route_design_recipe_template.md&prefill_Sentiment=🙂) [😀](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fweb-applications&prefill_File=resources%2Fsinatra_route_design_recipe_template.md&prefill_Sentiment=😀)  
Click an emoji to tell us.

<!-- END GENERATED SECTION DO NOT EDIT -->
