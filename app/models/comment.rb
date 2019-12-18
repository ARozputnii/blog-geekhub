# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  ancestry   :string
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  author_id  :bigint
#  post_id    :bigint           not null
#
# Indexes
#
#  index_comments_on_ancestry   (ancestry)
#  index_comments_on_author_id  (author_id)
#  index_comments_on_post_id    (post_id)
#
# Foreign Keys
#
#  fk_rails_...  (post_id => posts.id)
#

class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :author
  has_many   :votes, dependent: :destroy

  validates  :body, presence: true,
                    length: { minimum: 1 }
  # gem ancestry (вложенные коментарии)
  has_ancestry orphan_strategy: :adopt
end
