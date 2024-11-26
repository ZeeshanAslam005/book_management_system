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

  namespace :api do
    namespace :v1 do
      resources :bookstores, only: [:index, :show]
      resources :books, only: [:index, :show]
    end
  end

  root to: 'home#index'
end
