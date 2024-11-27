require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  resources :books, only: [:index]
  resources :bookstores, only: [:index]

  namespace :admin do
    resources :dashboard, only: [:index]
  end

  namespace :manager do
    resources :dashboard, only: [:index]
  end

  namespace :customer do
    resources :dashboard, only: [:index]
  end

  mount API::Base => '/'
  mount GrapeSwaggerRails::Engine => '/swagger', constraints: proc { !Rails.env.production? }

  root to: 'home#index'
end
