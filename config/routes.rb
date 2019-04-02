Rails.application.routes.draw do

  root "welcome#index"

  resources :items, only: [:index]

  get '/merchants', to: 'users#index', as: :merchants

  get '/cart', to: 'carts#show', as: :cart

  get '/login', to: 'sessions#new'

  get '/register', to: 'users#new'

end
