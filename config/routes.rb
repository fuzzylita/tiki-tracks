Rails.application.routes.draw do
  get 'drink_ingredients/new'
  get 'drink_ingredients/create'
  post 'rating', to: 'ratings#create', as: :ratings

  resources :users, only: [:show, :new, :create] do
    resources :drinks
  end
  get '/auth/facebook/callback' => 'users#create_facebook'

  get '/drinks', to: 'drinks#all'
  get '/drinks/proper', to: 'drinks#proper', as: :proper
  get '/drinks/:id', to: 'drinks#public', as: :drink

  resources :ingredients, only: [:index, :new, :create]
  get 'ingredients/list', to: 'ingredients#list', as: :ingredient_list

  get 'login', to: 'sessions#new'
  post 'logout', to: 'sessions#destroy'
  post 'sessions/create'
  
  root 'application#index'
end
