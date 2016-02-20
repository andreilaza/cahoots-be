require 'api_constraints'

Rails.application.routes.draw do
  
  scope module: :v1,
          constraints: ApiConstraints.new(version: 1, default: true) do

    resources :rooms, :only => [:index, :create]
    resources :users, :only => [:create]

    post 'pusher/auth', to: 'pusher#auth'
  end
  
end
