require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  resources :books
  resources :bookstores

  namespace :admin do
    resources :dashboard, only: [:index]
    resources :users, only: %i[index new create edit update destroy]
  end
  
  namespace :manager do
    resources :dashboard, only: [:index]
  end

  namespace :customer do
    resources :dashboard, only: [:index]
  end

  # Added a route for assigning books to managers (optional, if required)
  post 'assign_books_to_manager', to: 'books#assign_to_manager'

  mount API::Base => '/'
  mount GrapeSwaggerRails::Engine => '/swagger', constraints: proc { !Rails.env.production? }

  root to: 'home#index'
end
