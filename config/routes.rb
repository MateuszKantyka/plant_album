Rails.application.routes.draw do
  root 'mechanics#home'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get  '/login',  to: 'sessions#new'
  post '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  post '/comment', to: 'comments#create'
  delete '/comment', to: 'comments#destroy'
  get '/notification', to: 'mechanics#new'
  post '/notification', to: 'mechanics#create'
  resources :users
  resources :mechanics
end
