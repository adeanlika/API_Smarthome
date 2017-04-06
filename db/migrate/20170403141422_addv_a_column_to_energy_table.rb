class AddvAColumnToEnergyTable < ActiveRecord::Migration[5.0]
  def change
    add_column :energies, 'vA', :float

  end
end
