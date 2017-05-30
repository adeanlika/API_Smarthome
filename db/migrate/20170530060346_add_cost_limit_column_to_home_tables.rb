class AddCostLimitColumnToHomeTables < ActiveRecord::Migration[5.0]
  def change
    add_column :homes, :cost_limit, :float
  end
end
