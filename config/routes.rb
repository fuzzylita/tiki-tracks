Rails.application.routes.draw do
  get 'drink_ingredients/new'
  get 'drink_ingredients/create'

  resources :users, only: [:show, :new, :create] do
    resources :drinks
  end

  get '/drinks', to: 'drinks#all'
  get '/drinks/:id', to: 'drinks#public', as: :drink

  resources :ingredients, only: [:index, :new, :create]
  
  get 'login', to: 'sessions#new'
  post 'logout', to: 'sessions#destroy'
  post 'sessions/create'
  get '/auth/facebook/callback' => 'sessions#create_facebook'

  get 'ingredients/list', to: 'ingredients#list', as: :ingredient_list
  
  root 'application#index'
end
