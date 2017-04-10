class DropDeviceIdFromLight < ActiveRecord::Migration[5.0]
  def change
    remove_column :lights, :devices_id
  end
end
