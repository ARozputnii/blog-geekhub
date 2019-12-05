# == Schema Information
#
# Table name: authors
#
#  id              :bigint           not null, primary key
#  baned           :boolean          default(FALSE)
#  birthday        :string
#  email           :string
#  first_name      :string
#  gender          :string
#  last_name       :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_authors_on_email  (email) UNIQUE
#

class Author < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy


  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  has_one_attached :image
  has_secure_password

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true,
            format:     { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

  validates :password_digest, presence: true, length: { minimum: 8 }


end
