Rails.application.routes.draw do

  root "welcome#index"

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # get '/profile/orders', to: 'orders#index'

  # resources :users, only: [:create], as: :register
  # post '/register', to: 'users#create'
  resources :items, only: [:index, :show]

  # namespace :users, as: :profile do
  #   get '/edit', to: 'users#edit', as: :edit
  #   get '/', to: 'users#show'
  #   get '/orders', to: 'orders#index'
  #   resources :orders, only: [:show]
  # end

  get '/register', to: 'users#new'
  get '/profile/edit', to: 'users#edit', as: :edit_profile
  get '/profile', to: 'users#show'
  resources :users, only:  [:index, :create, :update]

  resources :users, only: [:destroy], as: :profile do #send key value of order_id, change to scope, remove destroy
    resources :orders, only: [:index, :show]
  end

  resources :items, only: [:index]

  scope :dashboard, as: :dashboard do
    get '/orders/:id', to: 'merchants/orders#show', as: :order
    get '/items', to: 'merchants/items#index'
    get '/items/new', to: 'merchants/items#new'
    post '/items', to: 'merchants/items#create'
    get '/orders/', to: 'merchants/orders#index', as: :orders
  end

  get '/dashboard', to: 'merchants#show'
  resources :merchants, only: [:index, :show]
  # get '/order_items/:id', to: 'merchants/order_items#update'#, as: :fulfill_order_item
  patch '/order_items/:id', to: 'merchants/order_items#update', as: :fulfill_order_item
  patch '/cart', to: 'carts#update', as: :edit_cart
  get '/cart', to: 'carts#show', as: :cart
  get '/carts', to: 'carts#create', as: :carts
  delete '/cart', to: 'carts#destroy'

  patch '/order/:id', to: 'orders#ship', as: :ship
  patch '/order/:id', to: 'orders#cancel', as: :cancel

  namespace :admin do
    resources :users, only: [:index, :show]
    resources :merchants, only: [:index, :show]
    get 'dashboard', to: 'admin#show', as: :dashboard
    # resources :orders, only: [:index]
  end

  # get 'admin/merchants/:id', to: 'admin/merchants#show', as: :admin_merchant
  post '/orders', to: 'orders#create'
end
