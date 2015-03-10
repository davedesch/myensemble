# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :outfit do
    image_url 'http://lorempixel.com/400/200/people'
    association :user
    title { Faker::Name.title}
    gender 'Ladies'

    trait :without_hashtags do
      caption {Faker::Hacker.say_something_smart}
    end

    trait :with_hashtags do
      caption {Faker::Hacker.say_something_smart + " #" + Faker::Hacker.ingverb }
    end
  end
end
