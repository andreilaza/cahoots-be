class V1::RoomsController < ApplicationController
  respond_to :json
  before_action :authenticate_with_token!, only: [:index]
  
  def index
    render json: 'asg', root: false
  end

  def show
    room = Room.where(:name => params[:id]).first

    render json: room, status: 201, root: false
  end

  def create
    room = Room.new(room_params)
    room.name = room_params[:name].parameterize
    
    user = User.new()
    user.name = params[:user_name]
    user.auth_token = SecureRandom.base64(20)

    if room.save
      user.room_id = room.id
      if user.save        
        room.auth_token = user.auth_token
        render json: room, status: 201, root: false
      else
        render json: user.errors, status: 201, root: false
      end      
    else
      render json: { errors: room.errors }, status: 422
    end
  end

  def add_users
    user = User.new(user_params)
    user.auth_token = SecureRandom.base64(20)
    user.room_id = params[:id]

    room = Room.find(params[:id])

    if user.save
      render json: room, status: 201, root: false
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  private
    def user_params
      params.permit(:name)
    end

    def room_params
      params.permit(:name)
    end
end
