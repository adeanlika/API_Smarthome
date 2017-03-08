class AddDevRefToAlerts < ActiveRecord::Migration[5.0]
  def change
    add_reference :alerts, :device, foreign_key: true
  end
end
