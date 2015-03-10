# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article do
    association :outfit, :without_hashtags
    association :article_type
    brand {Faker::Company.name}
    url {Faker::Internet.url}
    discontinued true
    vintage false
  end
end
