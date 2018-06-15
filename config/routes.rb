Rails.application.routes.draw do
  root 'informations#index'
  get '/cards' => 'cards#index'
  get '/search' => 'cards#search'
end
