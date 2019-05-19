require 'rails_helper'

# POST /api/users
describe "creates user successfully", type: :request do
  before do
    post '/api/users', params: { name: "John Doe", email: "johndoe@gmail.com", password: "passw0rD", password_confirmation: "passw0rD" }
  end

  it 'gets 200 response' do
    expect(response).to have_http_status(201)
  end

  it 'gets json with token' do
    expect(JSON.parse(response.body).keys).to include("id")
    expect(JSON.parse(response.body).keys).to include("email")
    expect(JSON.parse(response.body).keys).to include("password_digest")
  end
end

describe "fails to create user - invalid password", type: :request do
  before do
    post '/api/users', params: { name: "John Doe", email: "johndoe@gmail.com", password: "hi", password_confirmation: "hi" }
  end

  it 'gets 422 response' do
    expect(response).to have_http_status(422)
  end

  it 'gets json with token' do
    expect(JSON.parse(response.body).keys).to include("errors")
  end
end

describe "fails to create user - email already exists", type: :request do
  let!(:user) { User.create!(name: "John Doe", email: "johndoe@gmail.com", password: "passw0rD", password_confirmation: "passw0rD") }
  before do
    post '/api/users', params: { name: "John Doe", email: "johndoe@gmail.com", password: "passw0rD22", password_confirmation: "passw0rD22" }
  end

  it 'gets 422 response' do
    expect(response).to have_http_status(422)
  end

  it 'gets json with token' do
    expect(JSON.parse(response.body).keys).to include("errors")
  end
end
