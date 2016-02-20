class V1::UsersController < ApplicationController
  respond_to :json
  
  def create
    user = User.new(user_params)
    user.auth_token = SecureRandom.base64(20)

    if user.save
      render json: user, status: 201, root: false
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  private
    def user_params
      params.permit(:name)
    end
end
