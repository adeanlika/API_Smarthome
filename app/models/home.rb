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
	has_and_belongs_to_many :users
	has_many :devices
	has_many :energy
end
