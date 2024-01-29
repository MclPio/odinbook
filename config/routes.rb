Rails.application.routes.draw do
  root 'pages#home'
  devise_for :users, controllers: {
    registerations: 'user/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :users, only: :index

  resources :follows
end
