class Post < ApplicationRecord

	validates :author_id, presence: true
	validates :title, :content, presence: true,
						length: { minimum: 5 }



	belongs_to :author
	has_many :comments, dependent: :destroy
  has_one_attached :image
  is_impressionable

	def self.search(search)
		where("name LIKE ?", "%#{search}%")
		where("content LIKE ?", "%#{search}%")
	end
end
