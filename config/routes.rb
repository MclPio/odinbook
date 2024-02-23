Rails.application.routes.draw do
  resources :comments
  resources :posts do
    resources :comments, only: [:create]
  end
  root 'posts#index'
  devise_for :users, controllers: {
    registerations: 'user/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :users, only: [:index, :show, :edit, :update]

  resources :follows

  resources :likes, only: [:create, :destroy]
end
