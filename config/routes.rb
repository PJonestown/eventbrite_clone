Rails.application.routes.draw do

  get 'profiles/new'

  get 'profiles/create'

  get 'profiles/show'

  get 'profiles/edit'

  get 'profiles/update'

  get 'happenings/index'

  root to: 'happenings#index'

  resources :users do
    resources :profiles
    resources :moderations
    resources :mod_resources, only: [:index]
  end

  resources :events
  resources :gatherings, only: [:index]
  resources :attendances
  resources :gathering_attendances

  resources :groups do
    resources :gatherings
    resources :join_requests
    resources :memberships
  end

  resources :categories, only: [:show, :index] do
    resources :groups, only: [:index]
  end

  get     'sign_in'   =>  'sessions#new'
  post    'sign_in'   =>  'sessions#create'
  delete  'sign_out'  =>  'sessions#destroy'
end
