# == Schema Information
#
# Table name: authors
#
#  id                     :bigint           not null, primary key
#  baned                  :boolean          default(FALSE)
#  birthday               :string
#  confirm_token          :string
#  email                  :string
#  email_confirmed        :boolean          default(FALSE)
#  first_name             :string
#  gender                 :string
#  last_name              :string
#  password_digest        :string
#  password_reset_sent_at :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_authors_on_email  (email) UNIQUE
#

class Author < ApplicationRecord
  before_create :confirmation_token

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

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(validate: false)
  end

  def send_password_reset
    confirmation_token
    self.password_reset_sent_at = Time.zone.now
    save!
    AuthorMailer.password_reset(self).deliver
  end


  private

=begin
  #создание токина с присвоением до атрибута модели
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while Author.exists?(column => self[column])
  end
=end

  #создание токина
  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end

end
