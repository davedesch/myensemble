class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :outfit

  validates :stars, presence: true
  validates :stars, numericality: {less_than: 6}
  validates :stars, numericality: {greater_than: 0}

  validates :user, presence: true
  validates :outfit, presence: true

end
