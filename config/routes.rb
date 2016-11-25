Rails.application.routes.draw do
  root 'pages#home'

  get '/signup' => 'signup#new'
  post '/signup' => 'signup#create'

  get '/login' => 'login#new'
  post '/login' => 'login#create'
  post '/logout' => 'login#destroy'

  get '/user/:id' => 'user#index', as: 'user_page'
  get '/user/:id/edit' => 'user#edit', as: 'edit_user'
  patch '/user/:id/edit' => 'user#update'

  get 'photo/:id' => 'photo#index', as: 'photo'
  get 'user/:id/create_photo' => 'photo#new', as: 'create_photo'
  post 'user/:id/create_photo' => 'photo#create'

end
