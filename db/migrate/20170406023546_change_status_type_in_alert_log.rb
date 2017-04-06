class ChangeStatusTypeInAlertLog < ActiveRecord::Migration[5.0]
  def change
    change_column :alert_logs, :status, :string
  end
end
