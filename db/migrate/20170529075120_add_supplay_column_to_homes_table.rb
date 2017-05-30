class AddSupplayColumnToHomesTable < ActiveRecord::Migration[5.0]
  def change
    add_column :homes, :supply, :float
  end
end
