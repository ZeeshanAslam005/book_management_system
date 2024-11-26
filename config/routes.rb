Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    resources :dashboard, only: [:index]
  end

  namespace :manager do
    resources :dashboard, only: [:index]
  end

  namespace :customer do
    resources :dashboard, only: [:index]
  end

  root to: 'home#index'
end
