Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  

  root "pokemons#home"
  # Custom routes
  get 'about', to: 'pokemons#about'
  get 'home', to: 'pokemons#home'

  # Resource routes
  resources :pokemons, only: [:index, :show]
  resources :moves, only: [:index, :show]
  resources :types, only: [:index, :show]
  resources :regions, only: [:index, :show]

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

end
