Rails.application.routes.draw do
  #Root
  root to: "welcome#index"

  #Routes for Users
  get "/users", to: "users#index", as: "users"
  get "/signup", to: "users#new", as: "new_user"
  post "/users", to: "users#create"
  get "/users/:id", to: "users#show", as: "user"
  get "/users/:id/edit", to: "users#edit", as: "edit_user"
  patch "/users/:id", to: "users#update"
  delete "/users/:id", to: "users#destroy"

  #Route for Onboard
  get "/onboard", to: "users#onboard", as: "onboard_user"

  #Route for Note Instruction
  get "/users/:id/instruction", to: "users#display", as: "display_instruction"

  #Routes for Contact
  get "/users/:id/contact", to: "users#new_contact", as: "new_contact"
  post "/users/:id/contact", to: "contacts#create"

  #Routes for Notes
  get "/users/:id/notes", to: "users#new_note", as: "new_note"
  get "/users/:id/notes/:nid", to: "users#show_note", as: "show_note"
  get "/users/:id/completed", to: "users#complete_note", as: "complete_note"
  post "/users/:id/notes", to: "users#create_note"
  get "/users/:id/notes/:nid/edit", to: "users#edit_note", as: "edit_note"
  patch "/users/:id/notes/:nid", to: "users#update_note"
  

  # Routes for Sessions
  get "/login", to: "sessions#new", as: "new_session"   
  get "/logout", to: "sessions#destroy", as: "destroy_session"
  post "/sessions", to: "sessions#create" 
end
