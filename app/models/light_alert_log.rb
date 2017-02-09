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

class LightAlertLog < ApplicationRecord
	belongs_to :light
end
