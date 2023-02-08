FactoryBot.define do
  factory :spot do
    title { Faker::Book.title }
    description { Faker::Book.genre }
    price { 39.0 }
  end
end
