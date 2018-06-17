Rails.application.routes.draw do
  root 'informations#index'
  get '/cards' => 'cards#index'
  get '/search' => 'cards#search'
  get '/show' => 'cards#show'
end
