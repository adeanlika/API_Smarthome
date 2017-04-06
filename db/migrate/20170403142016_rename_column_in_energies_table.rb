class RenameColumnInEnergiesTable < ActiveRecord::Migration[5.0]
  def change
    rename_column :energies, :current, "cA"
    rename_column :energies, :power, :pwr
    rename_column :energies, :energy_delta, :energy
    rename_column :energies, :energy_total, :total
    rename_column :energies, :thd, "tvA"
    rename_column :energies, :pf, "pfA"
  end
end
