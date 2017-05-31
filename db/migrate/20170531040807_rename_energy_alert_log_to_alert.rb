class RenameEnergyAlertLogToAlert < ActiveRecord::Migration[5.0]
  def change
    rename_table :energy_alert_logs, :alert
  end
end
