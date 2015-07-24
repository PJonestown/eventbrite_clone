Rails.application.routes.draw do

  root to: 'groups#index'

  resources :users
  resources :events # Remove or only index
  resources :attendances
  resources :groups do
    resources :events
    resources :gatherings
  end
  resources :memberships

  get     'sign_in'   =>  'sessions#new'
  post    'sign_in'   =>  'sessions#create'
  delete  'sign_out'  =>  'sessions#destroy'
end
