class ChatSerializer < ApplicationSerializer
  attributes :id, :number, :messages_count
  has_one :application
end
