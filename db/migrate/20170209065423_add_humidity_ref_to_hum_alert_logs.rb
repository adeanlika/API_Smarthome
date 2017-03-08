class AddHumidityRefToHumAlertLogs < ActiveRecord::Migration[5.0]
  def change
    add_reference :hum_alert_logs, :humidity, foreign_key: true
  end
end
