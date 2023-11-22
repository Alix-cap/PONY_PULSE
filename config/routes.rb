Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :ponies, only: [:index, :show, :destroy]

  get "profile", to: "pages#profile"


end
