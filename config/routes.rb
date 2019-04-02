Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users

  root 'welcome#index'

  resources :items, only: [:index]

  resources :merchants, only: [:index]

  resources :users, only: [:new]

  get '/login', to: "sessions#new"

  get '/cart', to: "carts#show"


end
