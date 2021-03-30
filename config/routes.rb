Rails.application.routes.draw do
  root to: "posts#index"
  resources :comments, only: [:create, :edit, :update, :destroy]
  resources :posts
  resources :users, only: [:index]
  resources :friendships, only: [:create, :destroy, :update]

  devise_for :users
end
