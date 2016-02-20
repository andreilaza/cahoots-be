class Room < ActiveRecord::Base
  validates :name, presence: true
  validates :name, :uniqueness => {:message => "The room name should be unique"}, :case_sensitive => false
  
  has_many :users

  attr_accessor :auth_token
end
