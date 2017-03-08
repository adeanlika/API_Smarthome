class AddDeviceRefToAlertSettings < ActiveRecord::Migration[5.0]
  def change
    add_reference :alert_settings, :device, foreign_key: true
  end
end
