class ChatSerializer < ActiveModel::Serializer
  attributes :name, :number, :messages_count
  belongs_to :application
end
