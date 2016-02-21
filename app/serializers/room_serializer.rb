class RoomSerializer < ActiveModel::Serializer
  attributes :id, :name, :users, :auth_token, :locked, :pin, :created_at, :updated_at
  has_many :users
end
