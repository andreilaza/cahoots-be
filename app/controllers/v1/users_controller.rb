class V1::UsersController < ApplicationController
  respond_to :json
  
  def create
    user = User.new(user_params)
    user.auth_token = SecureRandom.base64(20)

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
