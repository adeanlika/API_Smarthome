class DropCo2Table < ActiveRecord::Migration[5.0]
  def change
    drop_table :CO2
  end
end
