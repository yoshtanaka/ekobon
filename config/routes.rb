Rails.application.routes.draw do
  get 'user/index'
  get 'user/:id' => "user#show"
  post 'user/signup' => "user#signup"
  post 'user/login' => "user#login"
  post 'user/logout' => "user#logout"
  post 'user/:id/update' => "user#update"
  post 'user/:id/pass_change' => 'user#pass_change'
  post 'user/:id/destroy' => 'user#destroy'

  get 'post/index' => 'post#index'
  get 'post/:id/show' => 'post#show'
  post'post/new_post' => 'post#new_post'
  post 'post/:id/destroy' => 'post#destroy'

  get '/' => "home#top"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
