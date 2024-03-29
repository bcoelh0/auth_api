Rails.application.routes.draw do
  namespace :api do
    root 'home#index'
    resources :users, except: :index
    post "/login", to: "authentication#login"
  end

  root "application#not_found"
  get "/*a", to: "application#not_found"
end
