Rails.application.routes.draw do

  get 'happenings/index'

  root to: 'happenings#index'

  resources :users do
    resources :moderations
    resources :mod_resources, only: [:index]
    resources :addresses
  end

  resources :events do
    resources :addresses
  end

  resources :gatherings, only: [:index]
  resources :attendances
  resources :gathering_attendances

  resources :groups do
    resources :gatherings, shallow: true do
      resources :addresses
    end
    resources :join_requests
    resources :memberships
    resources :addresses
  end

  resources :categories, only: [:show, :index] do
    resources :groups, only: [:index]
  end

  get     'sign_in'   =>  'sessions#new'
  post    'sign_in'   =>  'sessions#create'
  delete  'sign_out'  =>  'sessions#destroy'
end
