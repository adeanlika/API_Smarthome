# == Schema Information
#
# Table name: homes
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Home < ApplicationRecord
	# validates :devid, uniqueness: true
	has_many :users, through: :homes_users
	has_many :homes_users
	has_many :devices
	has_many :energy
	has_many :energy_alert_logs
end
