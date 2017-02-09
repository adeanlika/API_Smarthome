class AddMotionRefToMotionAlertLogs < ActiveRecord::Migration[5.0]
  def change
    add_reference :motion_alert_logs, :motion, foreign_key: true
  end
end
