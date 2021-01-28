FactoryBot.define do
  factory :chat do
    application_id { create(:application).id }
    number { 1 }
    messages_count { 1 }
  end
end
