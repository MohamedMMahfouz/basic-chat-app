class MessageSerializer < ApplicationSerializer
  attributes :id, :content, :number
  has_one :chat
end
