require 'sidekiq/web'

Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  mount Sidekiq::Web => '/sidekiq'

  root 'clients#index'

  devise_for :employees, skip: [:registrations, :passwords], controllers: { sessions: 'sessions' }
  devise_scope :employees do
    get 'change_password/:id', to: 'employees#change_password', as: :change_password
    get 'password/auth', to: 'password#auth'
    post 'password/auth', to: 'password#auth_action'
    get 'password/verify', to: 'password#verify'
    post 'password/verify', to: 'password#verify_action'
    get 'password/edit', to: 'password#edit'
    put 'password/update', to: 'password#update'
  end

  resources :page_elements
  resources :employees, except: [:show]
  resources :cuts, except: [:show, :destroy]
  resources :materials, except: [:show]
  resources :cities, except: [:show, :destroy]
  resources :details
  resources :roles, except: [:show, :destroy]
  resources :services, except: [:show]
  resources :delivery_payments

  resource :contacts, only: [:edit, :update]

  resources :individual_item, only: [:show] do
    resources :individual_item_shipments, only: [:index, :new, :create]
  end

  resources :individual_orders do
    put 'status_update', on: :member
  end

  resources :clients, except: [:destroy] do
    put 'ban', on: :member
    put 'unban', on: :member
    get 'edit_data', on: :member
  end

  scope :constructor, as: :constructor do
    get :options, to: 'constructor#options'
  end

  scope :constant, as: :constant do
    get :edit, to: 'constants#edit'
    put :update, to: 'constants#update'
  end
end
