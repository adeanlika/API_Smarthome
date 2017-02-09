class CreateMotionAlertLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :motion_alert_logs do |t|
      t.string :warning

      t.timestamps
    end
  end
end
