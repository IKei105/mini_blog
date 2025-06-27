Rails.application.routes.draw do
  get "posts/index"
  get "posts/create"
  
  get "up" => "rails/health#show", as: :rails_health_check

  root to: 'posts#index'
  resources :posts, only: [:index, :create]
end
