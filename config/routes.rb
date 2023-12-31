Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index,:new,:create,:show, :destroy]
  end

  resources :posts do
    resources :comments, only: [:new, :create, :destroy]
    resources :likes, only: [:create]
  end

  namespace :api do
    resources :users do
       resources :posts, only: [:index] do
        resources :comments, only: [:index, :create]
      end
    end
  end

  root 'users#index'
end
