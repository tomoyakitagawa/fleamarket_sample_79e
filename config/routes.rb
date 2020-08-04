Rails.application.routes.draw do
86d1e37119c0bc2950a9463b9f968232f80d7c71
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  } 
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_delivery_address'
    post 'addresses', to: 'users/registrations#create_address'
  end

  root 'items#index'
  resources :confirms, only: :index
  resources :details, only: :index
  resources :mypages, only: :index
  resources :cards, only: [:index, :new]
  resources :logs, only: :index
  resources :delivery_address, only: :index
  end



