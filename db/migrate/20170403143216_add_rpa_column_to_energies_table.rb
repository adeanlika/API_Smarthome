class AddRpaColumnToEnergiesTable < ActiveRecord::Migration[5.0]
  def change
    add_column :energies, "rpA", :float
  end
end
