Rails.application.routes.draw do
  #Root
  # root to: "home#index"

  #Routes for Users
  # devise_for :users

  resources :users

  # devise_scope :user do
  #   get "/users/sign_up", to: "devise/registrations#new", as: "new_user_registration"
  # end

  # get "/users/sign_up", to: "users#new"
  # get "/users", to: "users#index", as: "users"
  # get "/users/new", to: "users#new", as: "new_user"
end
