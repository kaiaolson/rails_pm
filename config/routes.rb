Rails.application.routes.draw do

  get "/home" => "home#index"
  get "/about" => "home#about"

  resources :projects do
    resources :tasks, only: [:create, :update, :destroy]
    resources :discussions, only: [:create, :destroy, :show]
    resources :favorites, only: [:create, :destroy]
    get "/advanced_search" => "projects#advanced_search"
  end

  resources :discussions, only: [:show, :edit, :update] do
    resources :comments, only: [:create, :destroy, :show]
  end

  resources :users, only: [:new, :create, :edit, :update, :show] do
    get "/change_password" => "users#change_password"
  end

  resources :sessions, only: [:new, :create, :destroy] do
    delete :destroy, on: :collection
  end

  resources :favorites, only: [:index]

  root "home#index"
end
