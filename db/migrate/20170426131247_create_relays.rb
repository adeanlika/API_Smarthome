class CreateRelaysNew < ActiveRecord::Migration[5.0]
  def change
    create_table :relays do |t|
        t.integer :relay1
        t.integer :relay2
        t.integer :relay3
        t.integer :relay4
        t.integer :relay5
        t.integer :relay6
        t.integer :relay7
        t.integer :relay8

        t.string :relay1name
        t.string :relay2name
        t.string :relay3name
        t.string :relay4name
        t.string :relay5name
        t.string :relay6name
        t.string :relay7name
        t.string :relay8name

        t.string :ac_brand
        t.string :ac_mode
        t.integer :ac_power
        t.string :ac_speed
        t.string :ac_swing
        t.integer :ac_enable
        t.integer :ac_temp

      t.timestamps
    end
  end
end
