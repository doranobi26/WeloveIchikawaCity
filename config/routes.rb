Rails.application.routes.draw do

  devise_for :users
  root 'homes#top'
  #root 'users#top'
  get 'home/about' => 'homes#about'
  get 'user/profile' => 'users#profile'

  resources :posts do
  	resources :comment, only: [:create, :destroy]
  resource :favorites, only: [:create, :destroy]
 end

  resources :users, only: [:index, :show, :edit, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
