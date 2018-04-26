class User < ActiveRecord::Base
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  has_secure_password
  has_many :ideas, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :ideas_liked, through: :likes, source: :idea
  before_validation :normalize_email, on: :create
  validates :name, :alias, :email, :password, presence: true
  validates :email, format: {with: EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 8}

  private
  def normalize_email
    self.email = email.downcase
  end

end
