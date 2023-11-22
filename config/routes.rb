Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :ponies, only: [:new, :create, :index, :show, :destroy] do
    resources :bookings, only: [:create]
  end

  get "profile", to: "pages#profile", as: "profile"
end
