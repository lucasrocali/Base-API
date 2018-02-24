class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :auth_token
end
