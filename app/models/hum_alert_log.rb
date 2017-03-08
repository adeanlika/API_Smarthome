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

class HumAlertLog < ApplicationRecord
	belongs_to :humidity
end
