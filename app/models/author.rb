class Author < ApplicationRecord
  has_many :posts, dependent: :destroy

  def full_name
    "#{first_name} #{last_name}"
  end

  has_secure_password
  validates :email, presence: true, uniqueness: true
end
