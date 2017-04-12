# == Schema Information
#
# Table name: motion_alert_logs
#
#  id         :integer          not null, primary key
#  warning    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  motion_id  :integer
#

class MotionAlertLog < ApplicationRecord
  belongs_to :motion
end
