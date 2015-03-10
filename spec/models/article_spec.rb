require 'rails_helper'

RSpec.describe Article, type: :model do
  after(:all) do
    Article.destroy_all
  end

  it "is associated with an outfit" do
    article = FactoryGirl.create :article
    expect(article).to respond_to :outfit
  end

  it "is valid with a brand and article_type" do
    article = FactoryGirl.create :article
    expect(article).to be_valid
  end

  it "is invalid without brand" do
    outfit = FactoryGirl.create :outfit , :without_hashtags
    type = ArticleType.create(type_desc: 'pants')
    article = Article.new(
      outfit: outfit,
      url: 'www.google.com',
      discontinued: false,
      vintage: true,
      article_type: type)
    article.valid?
    expect(article.errors[:brand]).to include("can't be blank")
  end

  it "is invalid without an article_type" do
    outfit = FactoryGirl.create :outfit , :without_hashtags
    article = Article.new(
      brand: 'good brand',
      outfit: outfit,
      url: 'www.google.com',
      discontinued: false,
      vintage: true)
    article.valid?
    expect(article.errors[:article_type]).to include("can't be blank")
  end

  it "defaults discontinued  and vintage to false" do
    outfit = FactoryGirl.create :outfit , :without_hashtags
    article = Article.new(
      brand: 'good brand',
      outfit: outfit,
      url: 'www.google.com')
    article.valid?
    expect(article.discontinued).to be(false)
    expect(article.vintage).to be(false)
  end

end
