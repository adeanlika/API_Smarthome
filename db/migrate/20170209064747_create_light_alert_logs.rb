class CreateLightAlertLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :light_alert_logs do |t|
      t.string :warning

      t.timestamps
    end
  end
end
