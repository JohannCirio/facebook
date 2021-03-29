Rails.application.routes.draw do
  resources :comments, only: [:create, :edit, :update, :destroy]
  resources :posts
  root to: "posts#index"
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
