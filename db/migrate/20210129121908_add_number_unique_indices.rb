class AddNumberUniqueIndices < ActiveRecord::Migration[5.2]
  def change
    add_index :chats,  [:application_id, :number], unique: true
    add_index :messages,  [:chat_id, :number], unique: true
  end
end
