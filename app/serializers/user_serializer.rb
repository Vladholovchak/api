# frozen_string_literal: true

class UserSerializer
  include JSONAPI::Serializer

  attributes :login, :avatar_url, :url, :name
end
