Rails.application.routes.draw do
  devise_for :users
  resources :posts, except: [:updated, :edit, :show]
  resources :users, except: [:new, :destroy]
  resources :relationships, only: [:create, :destroy]

  root 'posts#index'
end
