class RenameTypeToAlertTypeInEnergyAlertLog < ActiveRecord::Migration[5.0]
  def change
    rename_column :energy_alert_logs, :type, :alert_type
  end
end
