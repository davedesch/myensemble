# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do
  factory :user do
  	username { Faker::Internet.user_name }
    email { Faker::Internet.email }
    password_digest { Faker::Internet.password(6, 8) }
    avatar { Faker::Avatar.image }
  end
end
