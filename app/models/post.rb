# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  content    :text
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  author_id  :bigint
#
# Indexes
#
#  index_posts_on_author_id  (author_id)
#

class Post < ApplicationRecord

	validates :author_id, presence: true
	validates :title, :content, presence: true,
						length: { minimum: 5 }



	belongs_to :author
	has_many :comments, dependent: :destroy
  has_one_attached :image
  is_impressionable

	def self.search(search)
		where("title LIKE ? OR content LIKE ?", "%#{search}%","%#{search}%")
	end

end
