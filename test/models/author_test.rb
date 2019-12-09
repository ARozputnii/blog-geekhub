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
#  password_reset_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
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
