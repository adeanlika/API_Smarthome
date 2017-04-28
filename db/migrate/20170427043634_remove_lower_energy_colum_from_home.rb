class RemoveLowerEnergyColumFromHome < ActiveRecord::Migration[5.0]
  def change
    remove_column :homes, :lowerenergy
  end
end
