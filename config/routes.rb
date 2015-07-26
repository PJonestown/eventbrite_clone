Rails.application.routes.draw do

  root to: 'groups#index'

  resources :users
  resources :events
  resources :gatherings, only: [:index]
  resources :attendances
  resources :gathering_attendances
  resources :groups do
    resources :gatherings
  end
  resources :memberships

  get     'sign_in'   =>  'sessions#new'
  post    'sign_in'   =>  'sessions#create'
  delete  'sign_out'  =>  'sessions#destroy'
end
