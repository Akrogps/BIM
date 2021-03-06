Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'restaurants/autocomplete', to: 'restaurants#autocomplete'
  resources :restaurants do
    resources :bookings, only: [:new, :create]
  end
  resources :bookings, only: [:index]
end
