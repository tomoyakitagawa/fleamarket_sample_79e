Rails.application.routes.draw do
  root 'items#index'
  resources :confirms, only: :index
  resources :details, only: :index
end