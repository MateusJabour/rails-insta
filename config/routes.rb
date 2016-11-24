Rails.application.routes.draw do
  root 'pages#home'

  get '/signup' => 'signup#new'
  post '/signup' => 'signup#create'

  get '/login' => 'login#new'
  post '/login' => 'login#create'

  get '/user/:id' => 'user#index', as: 'user_page'
  get '/user/:id/edit' => 'user#edit', as: 'edit_user'
  patch '/user/:id/edit' => 'user#update'
end
