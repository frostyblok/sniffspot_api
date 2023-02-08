FactoryBot.define do
  factory :image do
    url { Faker::Internet.url }
    spot
  end
end
