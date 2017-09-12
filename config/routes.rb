Rails.application.routes.draw do
  root 'login#new'

  get '/timeline' => 'timeline#index'
  get '/signup' => 'signup#new'
  post '/signup' => 'signup#create'

  post '/login' => 'login#create'
  post '/logout' => 'login#destroy'

  get '/users' => 'user#list', as: 'users_list'
  get '/user/:id' => 'user#index', as: 'user_page'
  get '/user/:id/edit' => 'user#edit', as: 'edit_user'
  patch '/user/:id/edit' => 'user#update'
  post '/user/:id/follow' => 'relationship#create', as: 'follow_user'
  post '/user/:id/unfollow' => 'relationship#destroy', as: 'unfollow_user'
  get '/user/:id/notifications' => 'notification#index', as: 'notifications'

  get 'photo/:id' => 'photo#index', as: 'photo'
  get 'user/:id/create_photo' => 'photo#new', as: 'create_photo'
  post 'user/:id/create_photo' => 'photo#create'

  post 'photo/:id/create_comment' => 'photo#comment', as: 'create_comment'
  post 'photo/:id/like' => 'photo#like', as: 'like_photo'


end
