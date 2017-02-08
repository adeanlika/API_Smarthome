class CreateLights < ActiveRecord::Migration[5.0]
  def change
    create_table :lights do |t|
      t.float :value

      t.timestamps
    end
  end
end
