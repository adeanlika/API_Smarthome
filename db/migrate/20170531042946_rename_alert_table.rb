class RenameAlertTable < ActiveRecord::Migration[5.0]
  def change
    rename_table :alert, :alerts
  end
end
