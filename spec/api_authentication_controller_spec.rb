require 'rails_helper'

# POST /api/login
describe "Successfull login", type: :request do
  let!(:user) { User.create!(name: "John Doe", email: "johndoe@gmail.com", password: "passw0rD", password_confirmation: "passw0rD") }
  before do
    post '/api/login', params: { email: "johndoe@gmail.com", password: "passw0rD" }
  end

  it 'gets 200 response' do
    expect(response).to have_http_status(200)
  end

  it 'gets json with token' do
    expect(JSON.parse(response.body).keys).to include("token")
    expect(JSON.parse(response.body).keys).to include("email")
  end
end

describe "Unsuccessfull login", type: :request do
  let!(:user) { User.create!(name: "John Doe", email: "johndoe@gmail.com", password: "passw0rD", password_confirmation: "passw0rD") }
  before do
    post '/api/login', params: { email: "another_email@gmail.com", password: "passw0rD" }
  end

  it 'gets 401 response' do
    expect(response).to have_http_status(401)
  end

  it 'gets json with errors' do
    expect(JSON.parse(response.body).keys).to include("error")
  end
end
