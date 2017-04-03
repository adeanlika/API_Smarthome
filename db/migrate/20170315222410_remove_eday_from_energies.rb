class RemoveEdayFromEnergies < ActiveRecord::Migration[5.0]
  def change
    remove_column :energies, :Eday, :float
    remove_column :energies, :Eyear, :float
    remove_column :energies, :Emonth, :float

    end
end
