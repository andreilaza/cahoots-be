class CreatePusherEvents < ActiveRecord::Migration
  def change
    create_table :pusher_events do |t|
      t.text :event
      t.timestamps null: false
    end
  end
end
