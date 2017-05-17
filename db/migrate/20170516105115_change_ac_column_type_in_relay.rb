class ChangeAcColumnTypeInRelay < ActiveRecord::Migration[5.0]
  def change
    change_column :relays, :ac_power, :string
    change_column :relays, :ac_enable, :string
    change_column :relays, :ac_temp, :string
  end
end
