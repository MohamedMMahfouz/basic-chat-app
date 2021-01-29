class Chat < ApplicationRecord
  belongs_to :application, counter_cache: :chats_count
  has_many :messages

  def generate_number
    # self.lock!
    # last_chat = application.chats.last
    # byebug
    # self.number = (last_chat&.number || 0) + 1
    # save!
    Chat.connection.update(
      "Update chats,
      (
        SELECT applications.id, COUNT(c.id) as number
        FROM applications
        INNER JOIN chats c
        ON c.application_id = applications.id
        WHERE applications.id = #{application_id}
        GROUP BY applications.id
      ) as tmp
      SET
      chats.number = tmp.number
      WHERE chats.id = #{id}"
    )
  end
end
