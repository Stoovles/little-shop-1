Rails.application.routes.draw do
  root 'welcome#index'

  resources :items, only: [:index]

  resources :merchants, only: [:index]

  resources :users, only: [:new]

  get '/login', to: "sessions#new"

  get '/cart', to: "carts#show"

end
