class AddCostLimitFlagColumnToHomeTables < ActiveRecord::Migration[5.0]
  def change
    add_column :homes, :cost_limit_flag, :boolean
  end
end
