require 'rails_helper'

RSpec.describe Outfit, type: :model do

  after(:all) do
    User.destroy_all
    Outfit.destroy_all
  end

  it "is valid with a caption, an image and title" do
    pants = FactoryGirl.create :outfit, :without_hashtags
    expect(pants).to be_valid
  end

  it "is invalid without an caption" do
    pants = Outfit.new(
      title: 'title', image_url: 'www.google.com')
    pants.valid?
    expect(pants.errors[:caption]).to include("can't be blank")
  end

  it "is invalid without an image" do
    pants = Outfit.new(
      title: 'title', caption: 'www.google.com')
    pants.valid?
    expect(pants.errors[:image_url]).to include("can't be blank")
  end

  it "is invalid without an title" do
    pants = Outfit.new(
      caption: 'caption', image_url: 'www.google.com')
    pants.valid?
    expect(pants.errors[:title]).to include("can't be blank")
  end

  it "is associated with a user" do
    outfit = FactoryGirl.create :outfit, :without_hashtags
    expect(outfit).to respond_to :user
  end

  it "creates hashtags when they are in the caption" do
    outfit = FactoryGirl.create :outfit, :with_hashtags
    hashtag = outfit.hashtags.first
    expect(hashtag.class).to be(Hashtag)
  end

end

