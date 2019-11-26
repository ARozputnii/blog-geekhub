class Author < ApplicationRecord
  has_many :posts, dependent: :destroy

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  has_secure_password

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true,
            format:     { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

  validates :password, presence: true, length: { minimum: 8 }


end