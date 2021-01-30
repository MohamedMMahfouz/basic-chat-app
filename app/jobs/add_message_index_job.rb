class AddMessageIndexJob < ApplicationJob

  def perform
    Message.__elasticsearch__.create_index!
    Message.import
  end
end