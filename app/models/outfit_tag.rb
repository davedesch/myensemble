class OutfitTag < ActiveRecord::Base
  belongs_to :outfit
  belongs_to :hashtag
end
