class AddDeviceToAlertLog < ActiveRecord::Migration[5.0]
  def change
    add_reference :alert_logs, :device, foreign_key: true
  end
end
