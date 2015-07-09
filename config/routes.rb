Rails.application.routes.draw do

  resources :users
  resources :events

  root to: 'users#new' # temporary

  get     'sign_in'   =>  'sessions#new'
  post    'sign_in'   =>  'sessions#create'
  delete  'sign_out'  =>  'sessions#destroy'

  #match 'login' => 'sessions#create'
end
