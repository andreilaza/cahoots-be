require 'api_constraints'

Rails.application.routes.draw do
  
  scope module: :v1,
          constraints: ApiConstraints.new(version: 1, default: true) do

    resources :rooms, :only => [:index, :create, :show]
    resources :users, :only => [:create]

    # Pusher routes
    post 'pusher/auth', to: 'pusher#auth'
    get 'pusher/publish', to: 'pusher#publish'
    get 'pusher/receive', to: 'pusher#receive'
    get 'pusher', to: 'pusher#index'

    # Room routes
    post 'rooms/:id/users', to: 'rooms#add_users'
    post 'rooms/:id/lock', to: 'rooms#lock'
    delete 'rooms/:id/users/:user_id', to: 'rooms#remove_user'
  end
  
end
