Rails.application.routes.draw do
  resources :posts do
      resources :comments, except: ['index','new']
  end
  resources :collections
  resources :photos do
    member do
      put "like" => "photos#vote"
    end
  end
  devise_for :users
  resources :users, :only => [:show, :index]
  match 'index', to: 'photos#index', via: :all
  match 'users/:id', to: 'users#show', via: :all
  root to: 'photos#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
