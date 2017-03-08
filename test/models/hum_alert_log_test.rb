# == Schema Information
#
# Table name: hum_alert_logs
#
#  id          :integer          not null, primary key
#  warning     :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  humidity_id :integer
#

require 'test_helper'

class HumAlertLogTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
