FactoryBot.define do
  factory :tweet do
    text  {Faker::Lerom.sentence}
    image {Faker::Lerom.sentence}
    association :user
  end
end
