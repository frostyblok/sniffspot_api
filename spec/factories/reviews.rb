FactoryBot.define do
  factory :reviews do
    content { Faker::Quote.most_interesting_man_in_the_world }
    spot
  end
end
