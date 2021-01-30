class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.text :content
      t.references :chat, foreign_key: true
      t.integer :number, index: true

      t.timestamps
    end
  end
end
