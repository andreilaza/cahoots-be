# require 'rubygems'
# require 'pusher'
# require 'eventmachine'
require 'em-http-request'
# require 'pusher-client'

class V1::PusherController < ApplicationController
  # before_action :authenticate_with_token!
  def auth
    Pusher.app_id = '181477'
    Pusher.key = '765cd15f07fbd9b7ec2a'
    Pusher.secret = 'e0f1ec431f4df014af97'
    
    response = Pusher[params[:channel_name]].authenticate(params[:socket_id])
    
    render json: response
  end

  def publish
    Pusher.app_id = '181477'
    Pusher.key = '765cd15f07fbd9b7ec2a'
    Pusher.secret = 'e0f1ec431f4df014af97'

    EM.run {
      deferrable = Pusher['test_channel'].trigger_async('my_event', 'msg')

      deferrable.callback { # called on success
        render json: "Message sent successfully."
        EM.stop
      }
      deferrable.errback { |error| # called on error        
        render json: "Message could not be sent."
        # puts error
        EM.stop
      }
    }
  end

  def receive
    options = { secure: true }
    socket = PusherClient::Socket.new('765cd15f07fbd9b7ec2a', options)
    socket.connect(true)
    
    socket.subscribe('private-room-foo-red')

    socket['private-room-foo-red'].bind('client-partial-message') do |data|
      pusher_event = PusherEvent.new()
      pusher_event.event = data
      pusher_event.save      
    end

    loop do
      sleep 1
    end
  end

  def index
    events = PusherEvent.all
    render json: events, root: false, status: 200
  end
end