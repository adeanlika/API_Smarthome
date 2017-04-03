class RemoveEtotalFromEnergies < ActiveRecord::Migration[5.0]
  def change
    remove_column :energies, :Etotal, :float
  end
end
