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
	validates :devid,presence: true 
	validates :name,presence: true
	validates :gateway_id, presence: true
	has_many :users, through: :homes_users
	has_many :homes_users, dependent: :destroy
	has_many :devices, dependent: :destroy
	has_many :energy, dependent: :destroy
	has_many :energy_alert_logs, dependent: :destroy
end
