Rails.application.routes.draw do
  root 'posts#index'

  devise_for :users

  
  resources :users, only: %i[index show]
  resources :posts, only: %i[index create] do
    resources :comments, only: [:create]
    resources :likes, only: %i[create destroy]
  end
  get '/create_friendship', to: 'friendships#create_friendship'
  get '/accept_request', to: 'friendships#accept_request'
  get '/destroy_friendship', to: 'friendships#destroy_friendship'
end
