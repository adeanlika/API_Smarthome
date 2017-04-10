class AddLightTresholdToHome < ActiveRecord::Migration[5.0]
  def change
    add_column :homes, :lowerflux, :float
    add_column :homes, :upperflux, :float
  end
end
