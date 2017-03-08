class AddDeviceToCarbondioxides < ActiveRecord::Migration[5.0]
  def change
    add_reference :carbondioxides, :device, foreign_key: true
  end
end
