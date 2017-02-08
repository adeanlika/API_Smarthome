# == Schema Information
#
# Table name: homes_users
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  home_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class HomesUserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
