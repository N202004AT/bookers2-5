Rails.application.routes.draw do
  devise_for :users

  root :to => 'homes#top'
  get '/home/about' => 'homes#show'

  resources :users, only:[:index,:show,:edit,:update,:create]
  resources :books, only:[:new,:create,:index,:show,:edit,:update,:destroy]
  resources :relationships, only:[:create,:destroy]
  resources :books, only:[:new,:create,:index,:show,:destroy] do
  	resource :favorites, only:[:create, :destroy]
  	resource :book_comments, only:[:create,:destroy]
  end
  get '/followers/:id' => 'relationships#userfollower',as: 'myfollowers'
  get '/followings/:id' => 'relationships#userfollowing',as: 'myfollowings'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
