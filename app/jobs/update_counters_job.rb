class UpdateCountersJob < ApplicationJob
  def perform
    update_applications_counters
    update_chats_counters
  end

  private 

  def update_applications_counters
    Application.connection.update(
      "Update applications,
      (
        SELECT a.id, COUNT(c.id) as number
        FROM applications a
        INNER JOIN chats c
        ON c.application_id = a.id
        GROUP BY a.id
      ) as tmp
      SET
      applications.chats_count = tmp.number
      WHERE applications.id = tmp.id"
    )
  end


  def update_chats_counters
    Chat.connection.update(
      "Update chats,
      (
        SELECT c.id, COUNT(messages.id) as number
        FROM chats c
        INNER JOIN messages
        ON c.id = messages.chat_id
        GROUP BY c.id
      )
      as tmp
      SET
      chats.messages_count = tmp.number
      WHERE chats.id = tmp.id"
    )
  end
end
