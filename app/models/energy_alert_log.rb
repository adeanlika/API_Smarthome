# == Schema Information
#
# Table name: energy_alert_logs
#
#  id          :integer          not null, primary key
#  warning     :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  energies_id :integer
#  light_id    :integer
#

class EnergyAlertLog < ApplicationRecord
belongs_to :energy
end
