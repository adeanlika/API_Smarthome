class DropTableAlertLog < ActiveRecord::Migration[5.0]
  def change
    drop_table :alert_logs
  end
end
