class RenameEnergyColumnInTableEnergies < ActiveRecord::Migration[5.0]
  def change
    rename_column :energies, :energy, :energy_delta
  end
end
