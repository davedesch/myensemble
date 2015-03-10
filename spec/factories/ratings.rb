# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :rating do
    association :user
    association :outfit, :without_hashtags
    comment { Faker::Hacker.say_something_smart }
    stars 4
  end
end
