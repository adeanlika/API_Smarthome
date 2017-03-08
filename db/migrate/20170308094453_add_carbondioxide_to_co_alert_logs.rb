class AddCarbondioxideToCoAlertLogs < ActiveRecord::Migration[5.0]
  def change
    add_reference :co_alert_logs, :carbondioxide, foreign_key: true
  end
end
