FactoryBot.define do
  factory :message do
    content { "MyText" }
    chat
    number { 1 }
  end
end
