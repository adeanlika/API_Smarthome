class AddColumnToHomesTable < ActiveRecord::Migration[5.0]
  def change
    add_column :homes, :lowerenergy, :float
    add_column :homes, :upperenergy, :float
  end
end
