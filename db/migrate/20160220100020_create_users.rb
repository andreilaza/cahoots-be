class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, default: ""
      t.string :auth_token, default: ""
      
      t.timestamps null: false
    end

    add_index :users, :auth_token, unique: true
  end
end
