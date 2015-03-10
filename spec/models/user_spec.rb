require 'rails_helper'

RSpec.describe User, type: :model do

  after(:all) do
    User.destroy_all
  end

  it "is valid with a username, and email" do
    dave = FactoryGirl.create(:user)
    expect(dave).to be_valid
  end

  it "is invalid without an email" do
    user = User.new(
      username: 'username')
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it "does not allow duplicate usernames" do
    user1 = FactoryGirl.create(:user)
    user2 = User.new(username: user1.username, email: "dave@dave.com")
    user2.valid?
    expect(user2.errors[:username]).to include("has already been taken")
  end

  it "does not allow duplicate emails" do
    user1 = FactoryGirl.create(:user)
    user2 = User.new(username: "ausername", email: user1.email)
    user2.valid?
    expect(user2.errors[:email]).to include("has already been taken")
  end

  it "is invalid with an invalid email address" do
    user = FactoryGirl.create(:user)
    user.email = 'notanemial'
    user.save
    expect(user).not_to be_valid
  end


end
