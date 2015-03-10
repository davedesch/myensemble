# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :favorite_outfit do
    association :user
    association :outfit
  end
   factory :favorite_article do
    association :user
    association :article
  end
   factory :favorite_user do
    association :user
    association :user
  end
   factory :favorite_hashtag do
    association :user
    association :hashtag
  end
end
