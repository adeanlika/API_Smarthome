class RenameColumnTvaInEnergies < ActiveRecord::Migration[5.0]
  def change
    rename_column :energies, :tvA, :tcA
  end
end
