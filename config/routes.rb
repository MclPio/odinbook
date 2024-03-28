Rails.application.routes.draw do
  resources :posts do
    resources :comments, only: [:create, :update, :edit, :destroy]
  end
  root 'posts#index'
  devise_for :users, controllers: {
    registerations: 'user/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :users, only: [:index, :show, :edit, :update]

  resources :follows

  resources :poly_likes, only: [:create, :destroy]

  get 'notifications', to: 'pages#notifcations'
end
