Rails.application.routes.draw do

  devise_for :users
  root 'homes#top'
  get 'home/about' => 'homes#about'
  get 'user/profile/:id' => 'users#profile',as:"user_profile"
  get 'user/favorite/:id' => 'users#favorite',as:"user_favorite"
  get 'search' => 'searchs#search'

  resources :posts do
  	resources :comments, only: [:create, :destroy]
  resource :favorites, only: [:create, :destroy]
 end

  resources :users, only: [:index, :show, :edit, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
