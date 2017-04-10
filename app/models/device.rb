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
has_many :alert_settings
has_many :carbondioxides
has_many :alert_logs
has_many :lights
accepts_nested_attributes_for :temperatures, :humidities, :carbondioxides, :motions, :alert_logs, :lights

end
