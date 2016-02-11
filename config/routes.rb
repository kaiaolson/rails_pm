Rails.application.routes.draw do

  get "/home" => "home#index"
  get "/about" => "home#about"
  get "/projects/index/:page" => "projects#index"

  resources :tasks
  resources :discussions do
    resources :comments, only: [:create, :destroy, :show]
  end
  resources :projects do
    resources :tasks, only: [:create, :destroy, :show]
  end
  resources :comments

  root "home#index"
end
