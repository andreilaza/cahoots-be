class V1::RoomsController < ApplicationController
  respond_to :json
  before_action :authenticate_with_token!
  
  def index
    render json: 'asg', root: false
  end

  def create
    room = Room.new(room_params)

    user = User.new()
    user.name = params[:user_name]
    user.auth_token = SecureRandom.base64(20)

    if room.save
      if user.save
        room = ActiveSupport::JSON.decode(room.to_json)

        room['user'] = ActiveSupport::JSON.decode(user.to_json)

        render json: room, status: 201, root: false
      else
        render json: user.errors, status: 201, root: false
      end      
    else
      render json: { errors: room.errors }, status: 422
    end
  end

  private
    def user_params
      params.permit(:user_name)
    end

    def room_params
      params.permit(:name)
    end
end
