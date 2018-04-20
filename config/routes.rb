Rails.application.routes.draw do
  get 'tags/index'

  resources :photos_comments
  post 'collections_photos/create'
  get 'collections_photos/delete'
  #get 'tags/index', as: 'search'

  resources :posts do
      resources :comments, except: ['index','new']
  end
  resources :collections
  resources :photos do
    resources :photos_comments, except: ['index','new']
    member do
      put "like" => "photos#vote"
    end
  end
  devise_for :users
  resources :users, :only => [:show, :index]
  match 'index', to: 'photos#index', via: :all
  match 'users/:id', to: 'users#show', via: :all
  match 'search', to: 'tags#index', via: :all
  post 'photos/download'
  root to: 'photos#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
