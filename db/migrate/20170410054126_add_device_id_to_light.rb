class AddDeviceIdToLight < ActiveRecord::Migration[5.0]
  def change
    add_reference :lights, :device, foreign_key: true
  end
end
