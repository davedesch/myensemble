class User < ActiveRecord::Base
  has_many :outfits
  has_many :ratings
  has_many :user_favorites
  has_many :favorites, through: :user_favorites

  validates :username,  presence: true
  validates :username, uniqueness: true
  validates :email, presence: true, unless: :auth_token, presence: true
  validates :email, uniqueness: true
  validates_format_of :email, :with => /\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}/ , if: :email, presence: true

  # def to_param
  #   username
  # end


include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

end
