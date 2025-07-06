Rails.application.routes.draw do
  get "follows/create"
  get "follows/destroy"
  devise_for :users, controllers: { registrations: "users/registrations" }
  resources :posts, only: [ :index, :create ]
  get "posts/following", to: "posts#following"
  root to: "posts#index"

  resources :users, only: [ :show ]
  resources :follows, only: [ :create, :destroy ]
end
