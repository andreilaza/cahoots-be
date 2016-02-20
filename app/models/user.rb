class User < ActiveRecord::Base
  validates :name, presence: true    
  validates :name, uniqueness: { scope: :room,
    message: "The username should be unique per room" }

  belongs_to :room
end
