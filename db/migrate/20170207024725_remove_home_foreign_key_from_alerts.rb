class RemoveHomeForeignKeyFromAlerts < ActiveRecord::Migration[5.0]
  def change
  	remove_foreign_key :homes, :alerts
  end
end
