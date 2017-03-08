class CreateMotions < ActiveRecord::Migration[5.0]
  def change
    create_table :motions do |t|
      t.float :value

      t.timestamps
    end
  end
end
