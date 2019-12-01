class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :author
  validates  :body, presence: true,
             length: { minimum: 1}
  # gem ancestry (вложенные коментарии)
  has_ancestry
end
