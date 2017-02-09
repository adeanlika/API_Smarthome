class DropAlertFromHomes < ActiveRecord::Migration[5.0]
  def change
  	remove_column :homes, :sensor
  	remove_column :homes, :max
  	remove_column :homes, :min
  end
end
