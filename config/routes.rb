Rails.application.routes.draw do
  resources :users, except: :index
  post "/login", to: "authentication#login"
  get "/logedin", to: "authentication#logedin"
  get "/*a", to: "application#not_found"
end
