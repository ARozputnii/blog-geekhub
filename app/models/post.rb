class Post < ApplicationRecord
	validates :title, :content, presence: :true
	validates :title,  length: { minimum: 6 }
	validates :content, length: { minimum: 10 }

	belongs_to :author
	has_many :comments, dependent: :destroy
end
