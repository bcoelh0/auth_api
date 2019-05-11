class Api::HomeController < ApplicationController
  before_action :authorize_request

  def index
    render json: { 
      message: "Welcome, you are logged in!",
      image: "https://media.giphy.com/media/KBfKueAjIJV8Q/giphy.gif"
    }, status: :ok
  end
end
