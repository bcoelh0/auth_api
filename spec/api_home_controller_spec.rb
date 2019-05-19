require 'rails_helper'

describe "get root path", type: :request do
  before { get '/api/' }

  it 'gets root' do
    expect(response).to have_http_status(401)
  end

  it 'gets json error' do
    expect(JSON.parse(response.body).keys).to include("errors")
  end
end

describe "get root path after login", type: :request do
  let!(:user) { User.create!(name: "John Doe", email: "johndoe@gmail.com", password: "passw0rD", password_confirmation: "passw0rD") }
  let!(:user_token) do
    # get current token
    post '/api/login', params: { email: "johndoe@gmail.com", password: "passw0rD" }
    JSON.parse(response.body)["token"]
  end

  before do
    get '/api/', params: {}, headers: { 'Authorization' => user_token }
  end

  it 'gets root' do
    expect(response).to have_http_status(200)
  end

  it 'gets json error' do
    expect(JSON.parse(response.body).keys).to include("message")
    expect(JSON.parse(response.body).keys).to include("image")
  end
end
