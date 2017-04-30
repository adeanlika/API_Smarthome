class CreateLightTable < ActiveRecord::Migration[5.0]
  def change
    create_table :lights do |t|

          t.float :value
          t.integer :device_id
            t.timestamps
    end
  end
end
