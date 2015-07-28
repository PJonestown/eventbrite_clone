Rails.application.routes.draw do

  root to: 'groups#index'

  resources :users do
    resources :moderations
  end
  resources :events
  resources :gatherings, only: [:index]
  resources :attendances
  resources :gathering_attendances
  resources :groups do
    resources :gatherings
    resources :join_requests
  end

  resources :categories, only: [:show, :index] do
    resources :groups, only: [:index]
  end
  resources :memberships

  get     'sign_in'   =>  'sessions#new'
  post    'sign_in'   =>  'sessions#create'
  delete  'sign_out'  =>  'sessions#destroy'
end
