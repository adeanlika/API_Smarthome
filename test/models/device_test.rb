# == Schema Information
#
# Table name: devices
#
#  id         :integer          not null, primary key
#  name       :string
#  productID  :string
#  img        :binary
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  home_id    :integer
#

require 'test_helper'

class DeviceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
