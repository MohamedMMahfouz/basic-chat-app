FactoryBot.define do
  factory :application do
    name { "MyString" }
    token { "MyString" }
  end

  trait :invalid do 
    name { nil }
  end
end
