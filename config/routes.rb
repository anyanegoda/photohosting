Rails.application.routes.draw do
  resources :posts
  resources :collections
  resources :photos
  devise_for :users
  resources :users, :only => [:show, :index]
  match 'index', to: 'photos#index', via: :all
  match 'users/show', to: 'users#show', via: :all
  root to: 'photos#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
