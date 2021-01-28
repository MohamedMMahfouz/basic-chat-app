class AddChatName < ActiveRecord::Migration[5.2]
  def change
    add_column :chats, :name, :string
  end
end
