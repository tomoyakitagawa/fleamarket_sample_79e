Rails.application.routes.draw do
  
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  } 

  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_delivery_address'
    post 'addresses', to: 'users/registrations#create_address'
  end

  root 'items#index'
  resources :items 
    #Ajaxで動くアクションのルートを作成
    collection do
      get 'category/get_category_children', to: 'items#get_category_children', defaults: { format: 'json' }
      get 'category/get_category_grandchildren', to: 'items#get_category_grandchildren', defaults: { format: 'json' }
    end
    #詳細画面実装後導入
    # resources :confirms, only: :index do
    #   collection do
    #     get 'done', to: 'confirms#done'
    #     post 'confirms', to: 'confirms#pay'
    #   end
    # end
  end
  
  #詳細画面実装後削除
  get 'confirms', to: 'confirms#index'
  post 'confirms', to: 'confirms#pay'
  resources :confirms, only: :index do
    collection do
      get 'done', to: 'confirms#done'
      post 'confirms', to: 'confirms#pay'
    end
  end

  resources :details, only: :index
  resources :mypages, only: :index
  resources :cards, only: [:index, :new, :show] do
    collection do
      post 'pay', to: 'cards#pay'
      post 'delete', to: 'cards#delete'
    end
  end 
  resources :logs, only: :index
  resources :delivery_address, only: :index
  resources :users, only: :show
  end