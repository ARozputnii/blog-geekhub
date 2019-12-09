Rails.application.routes.draw do
  get 'password_resets/new'
  ActiveAdmin.routes(self)
  root 'posts#index'

  resources :posts do
    resources :comments do
      resources :votes
      post '/dislikes' => 'votes#create_dis', as: :dislike_create
    end
  end

  resources :authors do
    member do
      get :confirm_email
    end
  end

  resources :sessions, only: [:new, :create, :destroy]
  get 'signup', to: 'authors#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  resources :password_resets

end
