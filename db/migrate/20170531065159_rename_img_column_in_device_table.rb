class RenameImgColumnInDeviceTable < ActiveRecord::Migration[5.0]
  def change
    change_column :devices, :img, :string
    rename_column :devices, :img, :picture 
  end
end
