Rails.application.routes.draw do
  root to: "posts#index"
  resources :comments, only: [:create, :edit, :update, :destroy] do
    resources :likes, only: [:create, :destroy]
  end
  resources :posts do
    resources :likes, only: [:create, :destroy]
  end
  resources :friendships, only: [:index, :create, :destroy, :update]
  
  devise_for :users
end
