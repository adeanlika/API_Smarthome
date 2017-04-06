class AddDevidToEnergiesTable < ActiveRecord::Migration[5.0]
  def change
    add_column :energies, :devid, :integer
  end
end
