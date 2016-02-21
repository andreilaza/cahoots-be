require 'em-http-request'

class V1::RoomsController < ApplicationController
  respond_to :json
  before_action :authenticate_with_token!, only: [:index]#, :lock]
  
  def index
    render json: 'asg', root: false
  end

  def show
    room = Room.where(:name => params[:id]).first

    if room
      render json: room, status: 200, root: false
    else
      render json: { errors: "Room not found"}, status: 404, root: false
    end
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

    room = Room.where(:name => params[:id]).first

    user.room_id = room.id

    existing = User.where(:name => params[:name]).first

    if existing
      unique = false

      while unique == false do
        append = rand(1..9999)
        name = params[:name] + append.to_s        
        new_existing = User.where(:name => name).first
        
        if new_existing
          unique = false
        else
          unique = true
          user.name = name
        end
      end      
    end    
    
    if user.save
      render json: room, status: 201, root: false
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def remove_user
    room = Room.where(:name => params[:id]).first

    user = User.where('id' => params[:user_id], 'room_id' => room.id).first

    if user
      user.destroy
      render json: room, status: 201, root: false
    else
      render json: { errors: "User not found" }, status: 404
    end
  end
  def lock
    room = Room.where(:name => params[:id]).first

    room.locked = params[:lock]

    if params[:lock] == true
      unique = false
      
      while unique == false do
        pin = rand(1000..9999)

        unique_pin = Room.where(:pin => pin).first

        if unique_pin
          unique = false
        else
          unique = true
          room.pin = pin
        end
      end      
    end

    if params[:lock] == false
      room.pin = nil
    end

    if room.save
      render json: room, status: 201, root: false
    else
      render json: { errors: room.errors }, status: 422
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
