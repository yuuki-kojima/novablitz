Rails.application.routes.draw do
  root 'informations#index'
  get '/cards' => 'cards#index'
end
