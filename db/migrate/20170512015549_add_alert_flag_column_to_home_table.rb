class AddAlertFlagColumnToHomeTable < ActiveRecord::Migration[5.0]
  def change
    add_column :homes, :lowertemp_flag, :boolean
    add_column :homes, :uppertemp_flag, :boolean
    add_column :homes, :lowerhum_flag, :boolean
    add_column :homes, :upperhum_flag, :boolean
    add_column :homes, :lowerco_flag, :boolean
    add_column :homes, :upperco_flag, :boolean
    add_column :homes, :upperenergy_flag, :boolean
    add_column :homes, :lowerflux_flag, :boolean
    add_column :homes, :upperflux_flag, :boolean
      end
end
