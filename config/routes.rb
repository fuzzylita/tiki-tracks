Rails.application.routes.draw do
  resources :users, only: [:show, :new, :create] do
    resources :drinks, only: [:show, :new, :create, :edit, :delete]
  end

  resources :drinks, only: [:index] do
    resources :ingredients, only: [:index, :new, :create]
  end

  resources :ingredients, only: [:index]

  get 'login', to: 'sessions#new'
  post 'logout', to: 'sessions#destroy'
  post 'sessions/create'
  get '/auth/facebook/callback' => 'sessions#create_facebook'
  
  root 'application#index'
end
