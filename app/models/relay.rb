# == Schema Information
#
# Table name: relays
#
#  id          :integer          not null, primary key
#  relay1      :binary(1)        default("x'7827333027'")
#  relay2      :binary(1)        default("x'7827333027'")
#  relay3      :binary(1)        default("x'7827333027'")
#  relay4      :binary(1)        default("x'7827333027'")
#  relay5      :binary(1)        default("x'7827333027'")
#  relay6      :binary(1)        default("x'7827333027'")
#  relay7      :binary(1)        default("x'7827333027'")
#  relay8      :binary(1)        default("x'7827333027'")
#  relay1name  :string
#  relay2name  :string
#  relay3name  :string
#  relay4name  :string
#  relay5name  :string
#  relay6name  :string
#  relay7name  :string
#  relay8name  :string
#  acname      :string
#  acmode      :binary(4)        default("x'7827333027'")
#  acstate     :binary(4)        default("x'7827333027'")
#  acspeed     :binary(4)        default("x'7827333027'")
#  acdirection :binary(4)        default("x'7827333027'")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  device_id   :integer
#

class Relay < ApplicationRecord
	belongs_to :device
end
