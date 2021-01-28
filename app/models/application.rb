class Application < ApplicationRecord
  has_secure_token

  has_many :chats

  validates_presence_of :name
end
