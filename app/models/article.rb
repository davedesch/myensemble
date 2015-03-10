class Article < ActiveRecord::Base
  belongs_to :outfit
  belongs_to :article_type
  has_many :favorites, as: :fave

  validates :outfit, presence: true
  validates :article_type, presence: true
  validates :brand, presence: true

end
