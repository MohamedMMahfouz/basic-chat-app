class MessageSerializer < ActiveModel::Serializer
  attributes :content, :number
  belongs_to :chat
end
