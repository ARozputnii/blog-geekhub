class Post < ApplicationRecord
	validates :title, :content, presence: :true
	validates :title,  length: { minimum: 6 }
	validates :content, length: { minimum: 10 }
end
