Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home", as: "home"
  resources :ponies, only: [:new, :create, :index, :show, :destroy] do
    resources :bookings, only: [:create]
  end
  resources :bookings, only: [] do
    member do
      patch :accept
      patch :decline
    end
  end
  get "profile", to: "pages#profile", as: "profile"
end
