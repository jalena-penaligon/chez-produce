Rails.application.routes.draw do

  root "welcome#index"

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :items, only: [:index, :show]

  get '/register', to: 'users#new'
  get '/profile/edit', to: 'users#edit', as: :edit_profile
  get '/profile', to: 'users#show'
  resources :users, only:  [:index, :create, :update]

  resources :users, only: [:destroy], as: :profile do
    resources :orders, only: [:index, :show, :update]
  end

  resources :items, only: [:index]

  scope :dashboard, as: :dashboard do
    get '/orders/:id', to: 'merchants/orders#show', as: :order
    get '/items', to: 'merchants/items#index'

    patch '/items/:id', to: 'items#active_toggle', as: :toggle_item
    delete '/items/:item_id', to: 'merchants/items#destroy', as: :delete_item

    get '/items/new', to: 'merchants/items#new'
    post '/items', to: 'merchants/items#create'
    get '/items/:id/edit', to: 'merchants/items#edit', as: :item_edit
    patch '/items/:id/edit', to: 'merchants/items#update', as: :item_update
    get '/orders/', to: 'merchants/orders#index', as: :orders
  end

  get '/dashboard', to: 'merchants#show'
  resources :merchants, only: [:index, :show]
  patch '/order_items/:id', to: 'merchants/order_items#update', as: :fulfill_order_item
  patch '/cart', to: 'carts#update', as: :edit_cart
  get '/cart', to: 'carts#show', as: :cart
  get '/carts', to: 'carts#create', as: :carts
  delete '/cart', to: 'carts#destroy'

  patch '/order/:id', to: 'orders#ship', as: :ship
  patch '/order/:id', to: 'orders#cancel', as: :cancel

  patch '/merchant/:id', to: 'users#active_toggle', as: :toggle_merchant

  namespace :admin do
    resources :users, only: [:index, :show]
    resources :merchants, only: [:index, :show]
    get 'dashboard', to: 'admin#show', as: :dashboard
    patch '/users/:id/upgrade', to: 'users#upgrade', as: :user_upgrade
    patch '/merchants/:id/downgrade', to: 'merchants#downgrade', as: :merchant_downgrade
  end

  post '/orders', to: 'orders#create'
end
