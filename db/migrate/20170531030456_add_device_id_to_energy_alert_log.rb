class AddDeviceIdToEnergyAlertLog < ActiveRecord::Migration[5.0]
  def change
    add_column :energy_alert_logs, :device_id, :integer
  end
end
