class AddDevRefToTemperatures < ActiveRecord::Migration[5.0]
  def change
    add_reference :temperatures, :device, foreign_key: true
  end
end
