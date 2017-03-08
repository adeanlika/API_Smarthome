class AddTempRefToTempAlertLogs < ActiveRecord::Migration[5.0]
  def change
    add_reference :temp_alert_logs, :temperature, foreign_key: true
  end
end
