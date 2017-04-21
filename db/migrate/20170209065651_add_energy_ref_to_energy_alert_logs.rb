class AddEnergyRefToEnergyAlertLogs < ActiveRecord::Migration[5.0]
  def change
    add_reference :energies, :homes, foreign_key: true
  end
end
