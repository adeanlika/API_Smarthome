class CreateEnergies < ActiveRecord::Migration[5.0]
  def change
    create_table :energies do |t|
      t.float :power
      t.float :Etotal
      t.float :Eday
      t.float :Emonth
      t.float :Eyear

      t.timestamps
    end
  end
end
