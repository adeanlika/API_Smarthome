class AddDevRefToHumidities < ActiveRecord::Migration[5.0]
  def change
    add_reference :humidities, :device, foreign_key: true
  end
end
