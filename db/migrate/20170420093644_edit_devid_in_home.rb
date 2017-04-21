class EditDevidInHome < ActiveRecord::Migration[5.0]
  def change
    change_column :energies, :devid, :string
  end
end
