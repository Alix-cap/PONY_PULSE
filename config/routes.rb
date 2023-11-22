Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :ponies, only: [:new, :create, :index, :show] do
    resources :bookings, only: [:create]
  end
end
