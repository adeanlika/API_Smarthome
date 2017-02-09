# == Schema Information
#
# Table name: alert_settings
#
#  id          :integer          not null, primary key
#  value       :integer
#  operation   :integer
#  sensor_type :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  device_id   :integer
#

require 'test_helper'

class AlertSettingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
