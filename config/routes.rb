Rails.application.routes.draw do
  #Root
  # root to: "home#index"

  #Routes for Users
  get "/users", to: "users#index", as: "users"
  get "/signup", to: "users#new", as: "new_user"
  post "/users", to: "users#create"
end
