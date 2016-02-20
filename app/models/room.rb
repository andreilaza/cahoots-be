class Room < ActiveRecord::Base
  validates :name, presence: true
  validates_uniqueness_of :name, :case_sensitive => false
  
  has_many :users

  attr_accessor :auth_token
end
