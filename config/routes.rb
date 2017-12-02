Rails.application.routes.draw do
  root 'mechanics#index'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get  '/login',  to: 'sessions#new'
  post '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users
  resources :mechanics
end
