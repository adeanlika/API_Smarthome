class RenameProductidColumInDevices < ActiveRecord::Migration[5.0]
  def change
    rename_column :devices, :productID, :product_id
  end
end
