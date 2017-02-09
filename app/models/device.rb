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

class Device < ApplicationRecord
belongs_to :home
has_many :alerts
has_one :relay
has_many :humidities
has_many :temperatures
has_many :motions
has_many :lights
has_many :alert_settings
end
