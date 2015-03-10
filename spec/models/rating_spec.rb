require 'rails_helper'

RSpec.describe Rating, type: :model do
  after(:all) do
    Rating.destroy_all
  end

  it "is associated with a user" do
    rating = FactoryGirl.create :rating
    expect(rating).to respond_to :user
  end

  it "is associated with an outfit" do
    rating = FactoryGirl.create :rating
    expect(rating).to respond_to :outfit
  end

  it "is valid with a comment, and a number of stars" do
    rating = FactoryGirl.create :rating
    expect(rating).to be_valid
  end

  it "is invalid without stars" do
    user = FactoryGirl.create :user
    outfit = FactoryGirl.create :outfit , :without_hashtags
    rating = Rating.new(
    comment: 'something awesome', outfit: outfit, user: user )
    rating.valid?
    expect(rating.errors[:stars]).to include("can't be blank")
  end

  it "is invalid when stars greater than 5" do
    user = FactoryGirl.create :user
    outfit = FactoryGirl.create :outfit , :without_hashtags
    rating = Rating.new(
    stars: 8, outfit: outfit, user: user )
    rating.valid?
    expect(rating.errors[:stars]).to include("must be less than 6")
  end

  it "is invalid when stars less than 0" do
    user = FactoryGirl.create :user
    outfit = FactoryGirl.create :outfit , :without_hashtags
    rating = Rating.new(
    stars: -1, outfit: outfit, user: user )
    rating.valid?
    expect(rating.errors[:stars]).to include("must be greater than 0")
  end

end
