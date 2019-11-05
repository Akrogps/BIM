Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :restaurants do
    resources :bookings, only: [:new, :create]
  end
  resources :bookings, only: [:index]
  resources :users, only: [:show]
end
