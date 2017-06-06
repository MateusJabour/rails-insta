Rails.application.routes.draw do
  root 'login#new'

  get '/signup' => 'signup#new'
  post '/signup' => 'signup#create'

  post '/login' => 'login#create'
  post '/logout' => 'login#destroy'

  get '/users' => 'user#list', as: 'users_list'
  get '/user/:id' => 'user#index', as: 'user_page'
  get '/user/:id/edit' => 'user#edit', as: 'edit_user'
  patch '/user/:id/edit' => 'user#update'
  post '/user/:id/follow' => 'relationship#create', as: 'follow_user'

  get 'photo/:id' => 'photo#index', as: 'photo'
  get 'user/:id/create_photo' => 'photo#new', as: 'create_photo'
  post 'user/:id/create_photo' => 'photo#create'

  post 'photo/:id/create_comment' => 'comment#create', as: 'create_comment'

  post 'photo/:id/like' => 'like#create', as: 'like_photo'


end
