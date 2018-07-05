Rails.application.routes.draw do
  devise_for :users
  root 'informations#index'
  get '/cards' => 'cards#index'
  get '/search' => 'cards#search'
  get '/show' => 'cards#show'
  resources :posts
end
