Rails.application.routes.draw do

  resources :users

  root to: 'users#new' # temporary

  get 'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create'
end
