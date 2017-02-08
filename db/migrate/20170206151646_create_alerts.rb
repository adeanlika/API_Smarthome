class CreateAlerts < ActiveRecord::Migration[5.0]
  def change
    create_table :alerts do |t|
      t.string :sensor_name
      t.float :value
      t.string :warning

      t.timestamps
    end
  end
end
