class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :room_id, :created_at, :updated_at  
end
