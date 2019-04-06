Rails.application.routes.draw do

  root "welcome#index"

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/logout', to: 'sessions#destroy'

  get '/profile', to: 'users#show', as: :profile
  get '/profile/edit', to: 'users#edit', as: :edit_profile
  get '/register', to: 'users#new'

  # resources :users, only: [:create], as: :register
  # post '/register', to: 'users#create'
  resources :items, only: [:index, :show]

  resources :users, only:  [:index, :create, :update]

  resources :items, only: [:index]
  resources :merchants, only: [:index]
  get '/cart', to: 'carts#show', as: :cart

  get '/dashboard', to: 'merchants#show'

  namespace :admin do
    get '/dashboard', to: 'users#show'
    resources :users, only: [:index, :show]
  end

  get 'admin/merchants/:id', to: 'admin/merchants#show', as: :admin_merchant

end
