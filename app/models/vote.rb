# == Schema Information
#
# Table name: votes
#
#  id         :bigint           not null, primary key
#  value      :integer
#  vote       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  author_id  :bigint           not null
#  comment_id :bigint           not null
#
# Indexes
#
#  index_votes_on_author_id   (author_id)
#  index_votes_on_comment_id  (comment_id)
#
# Foreign Keys
#
#  fk_rails_...  (author_id => authors.id)
#  fk_rails_...  (comment_id => comments.id)
#

class Vote < ApplicationRecord
  belongs_to :comment
  belongs_to :author

  #вещь может закладкой с помощью владельца максимум один раз
  # не работает на вложености коммент.
  # fixed by 'already_liked?' in vote_controller
  #validates_uniqueness_of :vote, scope: :author_id


end
