# == Schema Information
#
# Table name: temperatures
#
#  id         :integer          not null, primary key
#  value      :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  device_id  :integer
#

class Temperature < ApplicationRecord
	belongs_to :device
	has_many :temp_alert_logs
end
