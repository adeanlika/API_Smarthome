class DropCo2AlertLogsTable < ActiveRecord::Migration[5.0]
  def change
    drop_table :CO2_alert_logs
  end
end
