Rails.application.routes.draw do
  root 'dispray#index'
  devise_for :users
  root 'items#index'
  resources :confirms, only: :index
  resources :details, only: :index
  resources :mypages, only: :index
  resources :cards, only: [:index, :new]
  resources :logs, only: :index
  resources :delivery_address, only: :index
end
