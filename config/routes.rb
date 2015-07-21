Rails.application.routes.draw do

  root to: 'events#index'

  resources :users
  resources :events
  resources :attendances
  resources :groups

  get     'sign_in'   =>  'sessions#new'
  post    'sign_in'   =>  'sessions#create'
  delete  'sign_out'  =>  'sessions#destroy'
end
