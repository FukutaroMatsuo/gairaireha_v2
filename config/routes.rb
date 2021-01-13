Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root to: "rehas#index"
  # root to: "static_pages#index"
  resources :users, only: [:show]
  resources :patients
  resources :revenues
  resources :rehas, except: [:index]
  get "/day", to: "rehas#day", as: "day"
  get "list/:day", to: "rehas#list", as: "list"
end
