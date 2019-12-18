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
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy

  has_one_attached :image
  has_secure_password

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password_digest, presence: true, length: { minimum: 8 }
  validate :pass_val
  def pass_val
    if password.present?
      if password.count('a-z') <= 0 || password.count('A-Z') <= 0 # || password_digest.count((0-9).to_s) <= 0
        errors.add(:password, 'must contain 1 small letter, 1 capital letter and minimum 8 symbols')
      end
    end
  end

  before_create :confirmation_token

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

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

  #   #создание токина с присвоением до атрибута модели
  #   def generate_token(column)
  #     begin
  #       self[column] = SecureRandom.urlsafe_base64
  #     end while Author.exists?(column => self[column])
  #   end

  # создание токина
  def confirmation_token
    self.confirm_token = SecureRandom.urlsafe_base64.to_s if confirm_token.blank?
  end
end
