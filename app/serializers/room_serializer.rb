class RoomSerializer < ActiveModel::Serializer
  attributes :id, :name, :user, :created_at, :updated_at
end
