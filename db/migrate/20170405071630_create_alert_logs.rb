class CreateAlertLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :alert_logs do |t|
      t.string :sensor_name
      t.float :value
      t.integer :status

      t.timestamps
    end
  end
end
