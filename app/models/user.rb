class User < ActiveRecord::Base
  validates :name, presence: true    
  validates :name, uniqueness: { scope: :room,
    message: "Sorry, your name is already taken." }

  belongs_to :room
end
