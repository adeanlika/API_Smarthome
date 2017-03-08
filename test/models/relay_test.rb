# == Schema Information
#
# Table name: relays
#
#  id          :integer          not null, primary key
#  relay1      :binary(1)        default("x'78273738323733333330323727'")
#  relay2      :binary(1)        default("x'78273738323733333330323727'")
#  relay3      :binary(1)        default("x'78273738323733333330323727'")
#  relay4      :binary(1)        default("x'78273738323733333330323727'")
#  relay5      :binary(1)        default("x'78273738323733333330323727'")
#  relay6      :binary(1)        default("x'78273738323733333330323727'")
#  relay7      :binary(1)        default("x'78273738323733333330323727'")
#  relay8      :binary(1)        default("x'78273738323733333330323727'")
#  relay1name  :string
#  relay2name  :string
#  relay3name  :string
#  relay4name  :string
#  relay5name  :string
#  relay6name  :string
#  relay7name  :string
#  relay8name  :string
#  acname      :string
#  acmode      :binary(4)        default("x'78273738323733333330323727'")
#  acstate     :binary(4)        default("x'78273738323733333330323727'")
#  acspeed     :binary(4)        default("x'78273738323733333330323727'")
#  acdirection :binary(4)        default("x'78273738323733333330323727'")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  device_id   :integer
#

require 'test_helper'

class RelayTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
