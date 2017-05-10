class ChangeActempColumnTypeInRelays < ActiveRecord::Migration[5.0]
  def change
    change_column :relays, :ac_temp, :string
  end
end
