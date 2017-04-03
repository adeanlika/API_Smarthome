class RenameLightAlertLogsToCo2AlertLogs < ActiveRecord::Migration[5.0]
  def change
  	rename_table :light_alert_logs, :CO2_alert_logs
  end
end
