FactoryBot.define do
  factory :chat do
    application_id { create(:application).id }
    number { 1 }
    messages_count { 1 }
    name { "Name" }
    
    trait :invalid do 
      name { nil }
    end
  end
end
