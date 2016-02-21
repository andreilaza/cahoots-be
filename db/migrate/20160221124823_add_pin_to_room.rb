class AddPinToRoom < ActiveRecord::Migration
  def change
    add_column :rooms, :pin, :string, default: nil
  end
end
