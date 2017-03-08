class AddHomeRefToDevices < ActiveRecord::Migration[5.0]
  def change
    add_reference :devices, :home, foreign_key: true
  end
end
