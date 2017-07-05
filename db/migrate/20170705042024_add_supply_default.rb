class AddSupplyDefault < ActiveRecord::Migration[5.0]
  def change
      change_column_default(:homes, :supply, 1300)
  end
end
