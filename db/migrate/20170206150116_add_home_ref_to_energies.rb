class AddHomeRefToEnergies < ActiveRecord::Migration[5.0]
  def change
    add_reference :energies, :home, foreign_key: true
  end
end
