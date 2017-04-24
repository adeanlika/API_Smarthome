class AddHomerefToEnergyTable < ActiveRecord::Migration[5.0]
  def change
    add_reference :energy_alert_logs, :home, foreign_key: true
  end
end
