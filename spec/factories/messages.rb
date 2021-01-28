FactoryBot.define do
  factory :message do
    content { "MyText" }
    chat { nil }
    number { 1 }
  end
end
