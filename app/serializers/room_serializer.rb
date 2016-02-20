class RoomSerializer < ActiveModel::Serializer
  attributes :id, :name, :users, :auth_token, :created_at, :updated_at
  has_many :users
end
