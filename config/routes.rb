Rails.application.routes.draw do

  get "/home" => "home#index"
  get "/about" => "home#about"

  resources :projects do
    resources :tasks, only: [:create, :edit, :update, :destroy]
    resources :discussions, only: [:create, :destroy, :show]
    resources :favorites, only: [:create, :destroy]
    resources :memberships, only: [:create, :destroy]
    get "/advanced_search" => "projects#advanced_search"
  end

  resources :tasks do
    post :sort, on: :collection
  end

  resources :discussions, only: [:show, :edit, :update] do
    resources :comments, only: [:edit, :create, :update, :destroy, :show]
  end

  resources :users, only: [:new, :create, :edit, :update, :show] do
    get "/change_password" => "users#change_password"
  end

  resources :sessions, only: [:new, :create, :destroy] do
    delete :destroy, on: :collection
  end

  resources :favorites, only: [:index]

  root "home#index"

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :projects do
        resources :discussions
        resources :tasks
      end
    end
  end

  get "/auth/github", as: :sign_in_with_github
  get "/auth/github/callback" => "callbacks#github"
end
