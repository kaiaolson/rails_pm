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

  resources :users, only: [:new, :create, :edit, :update, :show] do
    get "/change_password" => "users#change_password"
  end
  resources :sessions, only: [:new, :create, :destroy] do
    delete :destroy, on: :collection
  end


  root "home#index"
end
