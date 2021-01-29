class Chat < ApplicationRecord
  belongs_to :application, counter_cache: :chats_count
  has_many :messages
  validates_presence_of :name
end
