class CreateCarbondioxides < ActiveRecord::Migration[5.0]
  def change
    create_table :carbondioxides do |t|
      t.float :value

      t.timestamps
    end
  end
end
