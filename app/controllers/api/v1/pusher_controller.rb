require 'pusher'

class Api::V1::PusherController < ApplicationController
  # before_action :authenticate_with_token!
  def auth
    Pusher.app_id = '181477'
    Pusher.key = '765cd15f07fbd9b7ec2a'
    Pusher.secret = 'e0f1ec431f4df014af97'
    
    response = Pusher[params[:channel_name]].authenticate(params[:socket_id])
    render json: response
  end
end