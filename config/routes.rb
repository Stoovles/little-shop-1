Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  resources :items, only: [:index,:show]

  resources :merchants, only: [:index]

  resources :users, only: [:new, :edit]

  resources :carts, only: [:create, :edit]


  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"

  get '/logout', to: "sessions#destroy"

  get '/profile', to: "users#show"
  post "/profile", to: "users#create"
  patch "/profile", to: "users#update"

  namespace :profile do
    resources :orders, only: [:index, :show, :update, :create]
  end

  get '/cart', to: "carts#show"
  delete '/cart', to: "carts#destroy"
  patch '/cart', to: "carts#update"

  get '/dashboard', to: "merchants#show"
  get '/dashboard/items', to: "items#index"

  namespace :admin do
    get '/dashboard', to: 'admins#show'
    resources :users, only: [:index, :show, :edit]
  end


end
