class Messages::CreateJob < ApplicationJob

  def perform(message_number, chat_id, message_params)
    chat = Chat.find(chat_id)
    chat.messages.create(message_params.merge(number: message_number))
  end
end