class AddCostColumnToHomeTable < ActiveRecord::Migration[5.0]
  def change
    add_column :homes, :electricity_price, :float, :default => 1467.28
  end
end
