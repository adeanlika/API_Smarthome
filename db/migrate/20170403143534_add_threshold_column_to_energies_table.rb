class AddThresholdColumnToEnergiesTable < ActiveRecord::Migration[5.0]
  def change
    add_column :homes, :lowertemp, :float
    add_column :homes, :uppertemp, :float
    add_column :homes, :lowerhum, :float
    add_column :homes, :upperhum, :float
    add_column :homes, :lowerco, :float
    add_column :homes, :upperco, :float
  end
end
