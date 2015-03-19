class Outfit < ActiveRecord::Base
  belongs_to :user
  has_many :ratings
  has_many :articles
  has_many :outfit_tags
  has_many :hashtags, through: :outfit_tags
  has_many :favorites, as: :fave
  accepts_nested_attributes_for :articles, :reject_if => lambda { |a| a[:brand].blank?}, :allow_destroy => true
  validates :caption, :image_url, :title, presence: true
  validates :user, presence: true

	after_save :check_for_hashtags

  def average_ratings
    avg = 0
    stars = []
    if self.ratings.count > 0
      self.ratings.each do |rating|
        stars << rating.stars
      end
      avg = stars.inject{ |sum, el| sum + el } / stars.size
    end
    return avg
  end

  def popularity
    popularity = 0
    if self.ratings.count > 0
      popularity = ratings.count * self.average_ratings
    end
    return popularity
  end

	private
		def check_for_hashtags
			hashtags = self.caption.scan(/#\w+/)
			if hashtags.length > 0
				hashtags.each do |hashtag|
					self.hashtags << Hashtag.find_or_create_by(hashtag: hashtag.downcase)
				end
			end
		end
end
