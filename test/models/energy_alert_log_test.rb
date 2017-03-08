# == Schema Information
#
# Table name: energy_alert_logs
#
#  id          :integer          not null, primary key
#  warning     :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  energies_id :integer
#  light_id    :integer
#

require 'test_helper'

class EnergyAlertLogTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
