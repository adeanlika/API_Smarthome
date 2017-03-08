# == Schema Information
#
# Table name: temp_alert_logs
#
#  id             :integer          not null, primary key
#  warning        :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  temperature_id :integer
#

require 'test_helper'

class TempAlertLogTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
