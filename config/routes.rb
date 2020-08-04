Rails.application.routes.draw d品出
  root 'dispray#index'
  devise_for users
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    }
  root 'items#index'
  resources :confirms, only: :index
  resources :details, only: :index
  resources :mypages, only: :index
  resources :cards, only: [:index, :new]
  resources :logs, only: :index
  resources :delivery_address, only: :index
  end
