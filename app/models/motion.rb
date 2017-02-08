# == Schema Information
#
# Table name: motions
#
#  id         :integer          not null, primary key
#  value      :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  device_id  :integer
#

class Motion < ApplicationRecord
	belongs_to :device
end
