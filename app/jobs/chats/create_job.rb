class Chats::CreateJob < ApplicationJob

  def perform(chat_number, application_id, chat_params)
    application = Application.find(application_id)
    application.chats.create(chat_params.merge(number: chat_number))
  end
end