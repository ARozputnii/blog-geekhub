# == Schema Information
#
# Table name: authors
#
#  id              :bigint           not null, primary key
#  baned           :boolean          default(FALSE)
#  birthday        :string
#  email           :string
#  first_name      :string
#  gender          :string
#  last_name       :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_authors_on_email  (email) UNIQUE
#

require 'test_helper'

class AuthorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
