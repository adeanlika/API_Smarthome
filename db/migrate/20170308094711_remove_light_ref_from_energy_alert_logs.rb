class RemoveLightRefFromEnergyAlertLogs < ActiveRecord::Migration[5.0]
  def change
    remove_column :energy_alert_logs, :light_id
  end
end
