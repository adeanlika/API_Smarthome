class ChangeAcpowerColumnTypeInRelays < ActiveRecord::Migration[5.0]
  def change
    change_column :relays, :ac_power, :string
  end
end
