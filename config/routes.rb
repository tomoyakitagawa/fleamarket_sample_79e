Rails.application.routes.draw d品出
  root 'dispray#index'
  devise_for users
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
end
