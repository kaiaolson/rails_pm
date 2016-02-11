Rails.application.routes.draw do

  get "/home" => "home#index"
  get "/about" => "home#about"
  get "/projects/index/:page" => "projects#index"

  resources :tasks
  resources :comments
  resources :discussions
  resources :projects do
    resources :tasks, only: [:create, :destroy, :show]
    resources :discussions, only: [:create, :destroy, :show]
  end
  resources :discussions do
    resources :comments, only: [:create, :destroy, :show]
  end


  root "home#index"
end
