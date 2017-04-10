class DropTableAlertLog < ActiveRecord::Migration[5.0]
  def change
    drop_table :motion_alert_logs
    drop_table :hum_alert_logs
    drop_table :temp_alert_logs
    drop_table :co_alert_logs
    drop_table :energy_alert_logs
  end
end
