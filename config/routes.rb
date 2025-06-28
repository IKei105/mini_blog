Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :posts, only: [:index, :create] 
  root to: 'posts#index'

  resources :profiles, only: [:new, :create]
end
