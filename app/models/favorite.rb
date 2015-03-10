class Favorite < ActiveRecord::Base
  has_many :user_favorites
  has_many :users, through: :user_favorites
  belongs_to :fave, polymorphic: true

end
