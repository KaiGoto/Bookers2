Rails.application.routes.draw do
  get 'search/search'
  devise_for :users
  root to: 'homes#top'
  get '/home/about', to: 'homes#about'
  resources :books, only: [:new, :create, :edit, :update, :index, :show, :destroy] do
   resource :favorites, only: [:create, :destroy]
   resources :book_comments, only: [:create, :destroy]
  end
  resources :users, only: [:show, :edit, :update, :create, :index] do
    resource :relationships, only: [:create, :destroy]
    get 'follow' => 'users#follow'
    get 'follower' => 'users#follower'
   end
   get '/search' => 'search#search'
end
