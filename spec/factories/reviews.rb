FactoryBot.define do
  factory :review do
    content { Faker::Quote.most_interesting_man_in_the_world }
    rating { rand(5) }
    spot
  end
end
