Rails.application.routes.draw do
  #Root
  root to: "home#index"

  #Routes for Users
  devise_for :users
  
  get "/users", to: "users#index", as: "users"
  get "/users/new," to: "users#new", as: "new_user"
end
