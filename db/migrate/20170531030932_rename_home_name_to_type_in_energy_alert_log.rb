class RenameHomeNameToTypeInEnergyAlertLog < ActiveRecord::Migration[5.0]
  def change
    rename_column :energy_alert_logs, :home_name, :type
  end
end
