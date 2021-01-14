Rails.application.routes.draw do
  root 'posts#index'

  devise_for :users

  resources :friendships, only: %i[destroy] do
    
      
    
  end
  resources :users, only: %i[index show]
  resources :posts, only: %i[index create] do
    resources :comments, only: [:create]
    resources :likes, only: %i[create destroy]
  end
  get '/create_friendship', to: 'friendships#create_friendship'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
