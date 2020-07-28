Rails.application.routes.draw do
  devise_for :users
  root 'items#index'
  resources :confirms, only: :index
  resources :details, only: :index
end