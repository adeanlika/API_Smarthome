# == Schema Information
#
# Table name: light_alert_logs
#
#  id         :integer          not null, primary key
#  warning    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  light_id   :integer
#

require 'test_helper'

class LightAlertLogTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
