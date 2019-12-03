Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  root 'posts#index'

  resources :posts do
    resources :comments do
      resources :votes
    end
  end

  resources :authors

  resources :sessions, only: [:new, :create, :destroy]
  get 'signup', to: 'authors#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
end
