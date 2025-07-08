Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }

  root to: "posts#index"

  namespace :api do
    resources :follows, only: [:create, :destroy]
  end

  resources :posts, only: [ :index, :create ]
  resources :users, only: [ :show ]
end
