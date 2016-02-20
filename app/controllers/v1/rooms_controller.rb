class V1::RoomsController < ApplicationController
  respond_to :json
  before_action :authenticate_with_token!
  
  def index
    render json: 'asg', root: false
  end
end
