# config/routes.rb

Bloccit::Application.routes.draw do

  devise_for :users
  resources :users, only: [:update, :show]

  resources :topics do
    resources :posts, except: [:index], controller: 'topics/post' do
      resources :likes, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
      resources :favorites, only: [:create, :destroy]
      get '/up-vote' => 'votes#up_vote', as: :up_vote
      get '/down-vote' => 'votes#down_vote', as: :down_vote
    end
  end

  get 'about' => 'welcome#about'

  root to: 'welcome#index'
end