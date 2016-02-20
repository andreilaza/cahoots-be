class User < ActiveRecord::Base
  validates :name, presence: true    
  validates :name, uniqueness: { scope: :room,
    message: "should be unique per room" }

  belongs_to :room
end
