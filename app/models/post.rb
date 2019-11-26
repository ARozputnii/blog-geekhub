class Post < ApplicationRecord
	validates :title, :content, presence: :true
	validates :title,  length: { minimum: 6 }
	validates :content, length: { minimum: 10 }

	belongs_to :author
	has_many :comments, dependent: :destroy
  has_one_attached :image
  is_impressionable

	def self.search(search)
		where("name LIKE ?", "%#{search}%")
		where("content LIKE ?", "%#{search}%")
	end
end
