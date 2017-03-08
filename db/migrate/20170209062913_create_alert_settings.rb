class CreateAlertSettings < ActiveRecord::Migration[5.0]
  def change
    create_table :alert_settings do |t|
      t.integer :value
      t.integer :operation
      t.integer :sensor_type

      t.timestamps
    end
  end
end
