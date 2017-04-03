class AddColumnToEnergies < ActiveRecord::Migration[5.0]
  def change
    add_column :energies, :energy_total, :float
      add_column :energies, :energy_delta, :float
        add_column :energies, :pf, :float
          add_column :energies, :thd, :float
            add_column :energies, :current, :float
  end
end
