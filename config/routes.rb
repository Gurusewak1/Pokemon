Rails.application.routes.draw do
  root "pokemons#home" 
  resources :pokemons, only: [:index, :show]
  resources :moves, only: [:index, :show]
  resources :types, only: [:index, :show]
  resources :regions, only: [:index, :show] 

  get 'about', to: 'pokemons#about'
   get 'home', to: 'pokemons#home'

 

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check
end
