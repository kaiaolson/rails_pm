Rails.application.routes.draw do

  get "/home" => "home#index"
  get "/about" => "home#about"

  resources :tasks
  resources :discussions
  resources :projects
  resources :comments

  root "home#index"
end
