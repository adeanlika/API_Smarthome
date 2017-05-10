class AddDeviceIdToRelay < ActiveRecord::Migration[5.0]
  def change
      add_reference :relays, :device, foreign_key: true
  end
end
