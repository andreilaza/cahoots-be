class AddLockToRoom < ActiveRecord::Migration
  def change
    add_column :rooms, :locked, :boolean, default: false
  end
end
