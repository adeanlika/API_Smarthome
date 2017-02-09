class DropAlertTable < ActiveRecord::Migration[5.0]
  def change
  	drop_table :alerts
  end
end
