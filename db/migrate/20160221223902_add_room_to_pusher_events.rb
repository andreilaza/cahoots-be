class AddRoomToPusherEvents < ActiveRecord::Migration
  def change
    add_column :pusher_events, :room, :string, default: nil
  end
end
