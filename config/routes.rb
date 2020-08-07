Rails.application.routes.draw do
  
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  } 

  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_delivery_address'
    post 'addresses', to: 'users/registrations#create_address'
  end

  root 'items#index'
  resources :items, only: [:index, :new, :create, :edit, :update, :destroy] do
    #Ajaxで動くアクションのルートを作成
    collection do
      get 'get_category_children', to: 'items#get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', to: 'items#get_category_grandchildren', defaults: { format: 'json' }
    end
  end
  
  resources :confirms, only: :index
  resources :details, only: :index
  resources :mypages, only: :index
  resources :cards, only: [:index, :new]
  resources :logs, only: :index
  resources :delivery_address, only: :index
  resources :users, only: :show
  end