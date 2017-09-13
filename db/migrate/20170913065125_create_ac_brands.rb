class CreateAcBrands < ActiveRecord::Migration[5.0]
  def change
    create_table :ac_brands do |t|
      t.string :brand
      t.string :code

      t.timestamps
    end
  end
end
