# == Schema Information
#
# Table name: motion_alert_logs
#
#  id         :integer          not null, primary key
#  warning    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  motion_id  :integer
#

require 'test_helper'

class MotionAlertLogTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
