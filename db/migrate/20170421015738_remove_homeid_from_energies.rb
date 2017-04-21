class RemoveHomeidFromEnergies < ActiveRecord::Migration[5.0]
  def change
    remove_column :energies, :home_id
  end
end
