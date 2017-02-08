# == Schema Information
#
# Table name: alerts
#
#  id          :integer          not null, primary key
#  sensor_name :string
#  value       :float
#  warning     :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  home_id     :integer
#  device_id   :integer
#

class Alert < ApplicationRecord
	belongs_to :device
end
