FactoryBot.define do
  factory :message do
    content { "MyText" }
    chat
    number { 1 }

    trait :invalid do 
      content { nil }
    end
  end
end
