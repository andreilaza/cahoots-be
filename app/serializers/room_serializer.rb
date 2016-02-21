class RoomSerializer < ActiveModel::Serializer
  attributes :id, :name, :users, :auth_token, :locked, :created_at, :updated_at
  has_many :users
end
